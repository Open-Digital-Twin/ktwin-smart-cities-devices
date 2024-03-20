import os
import math

class PeriodConfig:
    def __init__(self, full_time_frame: int, message_period: float) -> None:
        self.full_time_frame = full_time_frame
        self.message_period = message_period
        self.n_messages = math.ceil(full_time_frame/message_period)

def get_period_configs() -> list[PeriodConfig]:
    period_configs = list()

    full_time_frames = os.getenv("FULL_TIME_FRAMES")
    full_time_frames = full_time_frames.split(';')

    message_periods = os.getenv("MESSAGE_PERIOD")
    message_periods = message_periods.split(';')

    for i, _ in enumerate(full_time_frames):
        full_time_frame = int(full_time_frames[i])
        message_period = float(message_periods[i])
        period_config = PeriodConfig(full_time_frame=full_time_frame, message_period=message_period)
        period_configs.append(period_config)

    return period_configs
