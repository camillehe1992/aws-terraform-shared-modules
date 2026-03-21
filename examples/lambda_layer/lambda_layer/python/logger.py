import json
import logging
import os

# Configure a structured JSON logger
logging.basicConfig(level=os.getenv("LOG_LEVEL", "INFO").upper())
logger = logging.getLogger()


class StructuredLogger:
    """
    Simple structured JSON logger for AWS Lambda.
    Adds request_id, function_name and environment to every log entry.
    """

    def __init__(self, request_id=None, function_name=None, environment=None):
        self.request_id = request_id
        self.function_name = function_name or os.getenv("AWS_LAMBDA_FUNCTION_NAME")
        self.environment = environment or os.getenv("ENVIRONMENT", "dev")

    def _log(self, level, message, **kwargs):
        payload = {
            "level": level,
            "message": message,
            "function_name": self.function_name,
            "environment": self.environment,
            "request_id": self.request_id,
            **kwargs,
        }
        # Remove None values
        payload = {k: v for k, v in payload.items() if v is not None}
        logger.log(getattr(logging, level.upper()), json.dumps(payload))

    def info(self, message, **kwargs):
        self._log("info", message, **kwargs)

    def warning(self, message, **kwargs):
        self._log("warning", message, **kwargs)

    def error(self, message, **kwargs):
        self._log("error", message, **kwargs)

    def debug(self, message, **kwargs):
        self._log("debug", message, **kwargs)


# Convenience factory for Lambda context
def get_logger(context=None, **extra):
    """
    Returns a StructuredLogger instance pre-filled with Lambda context fields.
    Usage:
        from logger import get_logger
        log = get_logger(context)
        log.info("Hello from Lambda", user_id="123")
    """
    request_id = getattr(context, "aws_request_id", None)
    return StructuredLogger(request_id=request_id, **extra)
