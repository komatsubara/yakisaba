import shelve

d=shelve.open("shelvetest")
d.update({"one":1,"two":2})
print(list(d.items()))
d.close
