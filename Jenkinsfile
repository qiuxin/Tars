Jenkinsfile (Declarative Pipeline)

import com.eviware.soapui.impl.wsdl.submit.transport.jms.JMSConnectionBuilder
import com.eviware.soapui.impl.wsdl.submit.transports.jms.JMSEndpoint
import com.eviware.soapui.impl.wsdl.submit.transports.jms.util.HermesUtils
import hermes.Hermes
import javax.jms.*


pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "Hello World"'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
            }
        }
    }
}