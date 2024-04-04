import re

def clean_column_name(raw_cols):
    # Convierte a minúsculas y reemplaza espacios con guiones bajos
    cleaned_cols=[]
    for cols in raw_cols:
        aux=cols.lower().replace(" ", "_").replace(".", "_").replace("__","_").replace("(t)", 'time').replace('functional_loc_', 'functional_loc').replace("/","_").replace("(unit)","unit") .replace("customer_1","customer1") 
        cleaned_cols.append(aux)
    return cleaned_cols