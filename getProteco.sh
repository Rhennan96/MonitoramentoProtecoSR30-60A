#! /bin/sh

#Alarmes Visuais seus valores são 0 para <OK> e 1 Para <Alarmado>
alarme_bat_descarga='led5'
alarme_ca_anormal_entrada='led2'
alarme_fusivel_interrompido='led1'
alarme_tensao_alta_saida='led6'
alarme_desconexao_cc='led3'
alarme_bateria_em_carga='led4'
alarme_retificador_anormal='led0'
alarme_falha_ventilacao='led7'
#Monitoramento Tensão e Voltagem
tensao_saida_consumidor='ucons'
corrente_ur1='iur1'
corrente_ur2='iur2'
corrente_ur3='iur3'
corrente_ur4='iur4'
corrente_ur5='iur5'
corrente_ur6='iur6'
corrente_ur7='iur7'
corrente_ur8='iur8'
corrente_consumidor='iconsumidor'
corrente_bateria='ibateria'
potencia_watts='potencia'

#monitoramento ping
test_ping='ping'


if [ $test_ping = $1 ]; then
ping -q -c1 $2 > /dev/null
    if [ $? -eq 0 ]; then
        echo '0'
    else    
        echo '1'
    fi

elif [ $alarme_bat_descarga = $1 ]; then
     curl -s $2/status.xml | grep "led5" | cut -c 7-7

elif [ $alarme_ca_anormal_entrada = $1 ]; then
    curl -s $2/status.xml | grep "led2" | cut -c 7-7

elif [ $alarme_fusivel_interrompido = $1 ]; then
    curl -s $2/status.xml | grep "led1" | cut -c 7-7

elif [ $alarme_tensao_alta_saida = $1 ]; then
    curl -s $2/status.xml | grep "led6" | cut -c 7-7

elif [ $alarme_desconexao_cc = $1 ]; then
    curl -s $2/status.xml | grep "led3" | cut -c 7-7

elif [ $alarme_bateria_em_carga = $1 ]; then
    curl -s $2/status.xml | grep "led4" | cut -c 7-7

elif [ $alarme_retificador_anormal = $1 ]; then
    curl -s $2/status.xml | grep "led0" | cut -c 7-7

elif [ $alarme_falha_ventilacao = $1 ]; then
    curl -s $2/status.xml | grep "led7" | cut -c 7-7

elif [ $tensao_saida_consumidor = $1 ]; then
    curl -s $2/status.xml | grep "ucons" | sed -r  's/([a-zA-Z<>/]+)//g'

elif [ $corrente_ur1 = $1 ]; then
    curl -s $2/status.xml | grep "iur1" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur2 = $1 ]; then
    curl -s $2/status.xml | grep "iur2" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur3 = $1 ]; then
    curl -s $2/status.xml | grep "iur3" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur4 = $1 ]; then
    curl -s $2/status.xml | grep "iur4" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur5 = $1 ]; then
    curl -s $2/status.xml | grep "iur5" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur6 = $1 ]; then
    curl -s $2/status.xml | grep "iur6" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur7 = $1 ]; then
    curl -s $2/status.xml | grep "iur7" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_ur8 = $1 ]; then
    curl -s $2/status.xml | grep "iur8" | cut -c 6-12 | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_consumidor = $1 ]; then
    curl -s $2/status.xml | grep "iconsumidor" | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $corrente_bateria = $1 ]; then    
    curl -s $2/status.xml | grep "ibateria" | sed -r  's/([a-zA-Z<>/-]+)//g'

elif [ $potencia_watts = $1 ]; then
    corrent=`curl -s $2/status.xml | grep "iconsumidor" | sed -r  's/([a-zA-Z<>/-]+)//g' | cut -f 1 -d " "`
    tensao=`curl -s $2/status.xml | grep "ucons" | sed -r  's/([a-zA-Z<>/-]+)//g' | cut -f 1 -d " "`
    echo "scale=10; $corrent * $tensao" | bc -l

else
    echo 'Parametro Incorreto edite o arquivo getProteco.sh para entender melhor'
fi
