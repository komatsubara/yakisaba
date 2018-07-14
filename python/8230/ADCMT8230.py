"""
ADCMT8230の値を読むモジュールファイル
引数としてレンジと測定波長,スムージングするかどうか
戻り値として値とエラーを返す
"""
import sys

class ADCMT8230:
    def __init__(self,wavelength,measure_range,smoothing):
        self.wavelength=wavelength
        self.measure_range=measure_range
        self.smoothing=smoothing

    def main(self):
        print(self.wavelength)
    

if __name__ =='__main__':
    class ADCMT8230:
        def __init__(self,wavelength,measure_range,smoothing):
            try:
                self.wavelength=wavelength
                self.measure_range=measure_range
                self.smoothing=smoothing
            except:
                self.wavelength=1030
                self.measure_range=20
                self.smoothing=1
        def main(self):
            print(self.wavelength)
    
    c=ADCMT8230(1,1,1)
    c.main()
