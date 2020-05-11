$my_deployable_models_txt_path = -join($args[0],'\DeployableModels.txt')
$reader = New-Object System.IO.StreamReader($my_deployable_models_txt_path)
while (($readeachline = $reader.ReadLine()) -ne $null)
{
    $linelength = $readeachline.length
    $pathindex = $readeachline.LastIndexOf('/')
    $model_name=$readeachline.Substring($pathindex+1,$linelength-$pathindex-5)
    $execution_status= dbt run -m $model_name 
    echo "Status of execution : $execution_status"
    $test_status= dbt test -m $model_name 
    echo "Status of test : $test_status"
    $docs_status= dbt docs generate
    echo "Status of docs : $docs_status"
    #Start-Job -Name dbt_docs_serve -Init {Set-Location $args[0]} -ScriptBlock {dbt docs serve}
    #echo "DBT Docs Serve Job Initiated"
    
}
$reader.Dispose()
dbt docs serve
start  'http://127.0.0.1:8080/#!/overview'
#dbt docs generate
#$DbtDocsServer = dbt docs serve
#$path = $DbtDocsServer.Substring($DbtDocsServer.IndexOf('http:'),150)
#$Address =  ($path -split '\n')[0]
#$port =  $Address.Substring($Address.LastIndexOf(':'))
#$localhost = (($path  |  Select-String -Pattern "\d{1,3}(\.\d{1,3}){3}" -AllMatches).Matches.Value)[0]
#echo $port
#echo $localhost
#$Url = 'http://' + $localhost + $port + '/#!/overview'
#echo $Url
#start $Url
