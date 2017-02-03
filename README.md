# BCProgress
Custom progress with CALayer 
Usage example:
    
    BCProgressView *viewTest = [[BCProgressView alloc] initWithFrame:frame_uSpecify];
    [self.view addSubview:viewTest];
    [viewTest setProgress:0.8];
    [viewTest setProgressType:BCProgressViewTypeStraightLine];
    
There are 3 types of progress supported till now ,please refer to .h file.
