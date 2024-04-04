from sqlalchemy import create_engine,types, VARCHAR
from sqlalchemy.exc import SQLAlchemyError
def get_conexion():
    return create_engine('postgresql://postgres:joselo86@localhost:5432/databi')


def insert_table(cnn,schema, tabla,df_tabla, condiciones=None,tipo_datos=None):
    new_val=tipo_datos
    if tipo_datos is not None:
        dtype={'text':types.TEXT}
        new_val={ key:dtype[tipo_datos[key]] for key in tipo_datos}

    del_qry=f"delete from {schema}.{tabla} where 1=1"
    
    if condiciones is not None:
         del_qry+=" and "+condiciones
    
    try:
        with cnn.connect() as connection:
                connection.execute(del_qry)
    except:
        print(f"La tabla <<{schema}.{tabla}>> no existe, omitiendo")
    
    df_tabla.to_sql(tabla, cnn, schema=schema, if_exists='append', index=False,dtype=new_val)




def execute_qry(cnn,qry):
    try:
        with cnn.connect() as connection:
                print(f"Ejectutando "+qry[:60])
                connection.execute(qry)
    except:
        print(f"No se pudo ejecutar la consulta "+qry[:60])


def execute_sql_file(cnn, file):
    with open(file, 'r') as archivo:
        contenido_sql = archivo.read()

    sentencias_sql = contenido_sql.strip().split(';')
    for sentencia in sentencias_sql[:-1]:
        qry=sentencia.strip()
        execute_qry(cnn,qry)