"""
ADCMT8230の値を読むモジュールファイル
引数としてレンジと測定波長,スムージングするかどうか
戻り値として値とエラーを返す
"""
import visa
#import msvcrt
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
            rm=visa.ResourceManager()
            inst_id_list=rm.list_resources()
            num_of_inst=len(inst_id_list)


            print("number of inst : ",num_of_inst)
            for i in inst_id_list:
                inst_id=rm.open_resource(i)
                inst_name=inst_id.query("*IDN?")
                print(inst_id, " : ",inst_name)
#                if "8230" in inst_name:
#                    break
            self.value=inst_id.read()
            print(self.value)
    c=ADCMT8230(1,1,1)
    c.main()
