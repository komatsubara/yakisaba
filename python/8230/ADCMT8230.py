"""
ADCMT8230の値を読むモジュールファイル
引数としてレンジと測定波長,スムージングするか測定する単位を指定
戻り値として値とエラーを返す
"""
import visa
#import msvcrt
class Adcmt8230:
    def __init__(self,wavelength,measure_range,smoothing,measure_unit):
        try:
            self.wavelength=wavelength
            self.measure_range=measure_range
            self.smoothing=smoothing
            self.measure_unit=measure_unit
        except:
            self.wavelength=1030
            self.measure_range="auto"
            self.smoothing=1
        self.measure_range_comand={"auto":"R00","20nW":"R04","200nW":"R05","2000nW":"R06","20uW":"R07","200uW":"R08","2000uW":"R09","20mW":"R10","200mW":"R11"}
        self.measure_unit_dict={"W":"DW1","dB":"DW0"}
            
    def get_inst_id(self):
        rm=visa.ResourceManager()
        self.inst_id_list=rm.list_resources()
#            num_of_inst=len(inst_id_list)
#            print("number of inst : ",num_of_inst)
        for i in self.inst_id_list:
            self.inst_id=rm.open_resource(i)
            self.inst_name=self.inst_id.query("*IDN?")
#                print(inst_id, " : ",inst_name)
            if "8230" in self.inst_name:
                break
        return self.inst_id
    def set_condition(self,a): #a is self.inst_id=rm.openresource  
        inst_id=a
        inst_id.write(self.measure_unit_dict[self.measure_unit])   #decide measure unit
        inst_id.write(self.measure_range_comand[self.measure_range])    #decide measure range
        inst_id.write("WL",str(self.wavelength))                    #decide wavelength
        inst_id.write("ST",str(self.smoothing))
#            self.inst_id.write("BR0")

    def get_value(self,a):
        inst_id=a
        value=inst_id.read()
        print(value)

    def main(self):
        self.get_inst_id()
        self.set_condition(self.inst_id)
        self.get_value(self.inst_id)

if __name__ =='__main__':
    class Adcmt8230_main:
        def __init__(self,wavelength,measure_range,smoothing,measure_unit):
            try:
                self.wavelength=wavelength
                self.measure_range=measure_range
                self.smoothing=smoothing
                self.measure_unit=measure_unit
            except:
                self.wavelength=1030
                self.measure_range="auto"
                self.smoothing=1
            self.measure_range_comand={"auto":"R00","20nW":"R04","200nW":"R05","2000nW":"R06","20uW":"R07","200uW":"R08","2000uW":"R09","20mW":"R10","200mW":"R11"}
            self.measure_unit_dict={"W":"DW1","dB":"DW0"}

        def get_inst_id(self):
            rm=visa.ResourceManager()
            self.inst_id_list=rm.list_resources()
#            num_of_inst=len(inst_id_list)
#            print("number of inst : ",num_of_inst)
            for i in self.inst_id_list:
                self.inst_id=rm.open_resource(i)
                self.inst_name=self.inst_id.query("*IDN?")
#                print(inst_id, " : ",inst_name)
                if "8230" in self.inst_name:
                    break

        def set_condition(self,a): #a is self.inst_id=rm.openresource  
            inst_id=a
            inst_id.write(self.measure_unit_dict[self.measure_unit])   #decide measure unit
            inst_id.write(self.measure_range_comand[self.measure_range])    #decide measure range
            inst_id.write("WL",str(self.wavelength))                    #decide wavelength
            inst_id.write("ST",str(self.smoothing))
#            self.inst_id.write("BR0")

        def get_value(self,a):
            inst_id=a
            value=inst_id.read()
            print(value)

        def main(self):
            self.get_inst_id()
            self.set_condition(self.inst_id)
            self.get_value(self.inst_id)

    c=Adcmt8230_main(1030,"auto",0,"W")
    c.main()
