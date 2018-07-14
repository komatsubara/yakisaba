from ADCMT8230 import ADCMT8230 


class Test:
    def adcmt8230_part(self):
        self.wavelength=1030
        self.measurement_range=20
        self.smoothing=1
        self.c=ADCMT8230(self.wavelength,self.measurement_range,self.smoothing)
        self.c.main()

    def main(self):
        self.adcmt8230_part()

d=Test()
d.main()
