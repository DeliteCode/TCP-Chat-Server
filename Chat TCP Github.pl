# TCP/IP - Servidores



use Socket;

my $protocol = getprotobyname('tcp');
my $host = inet_aton('localhost'); 
my $port = 49500;


my $listening_address = sockaddr_in($port, $host);
bind($server_socket, $listening_address);
listen($server_socket, SOMAXCONN);




my $client_id = 0;

print "Aguardando conexoes...\n";

	# print "Loop Principal em execucao. Monitorando o socket\n";
	
	
	#configurando os valores necessarios para select realizar o monitoramento
	
	my $socket_monitorado = fileno($server_socket);
	vec($rin, $socket_monitorado, 1) = 1; 
	
		my $csocket = $connected_clients{$id}->{socket};
		vec($rin, fileno($csocket), 1) = 1;
	
	
	
	
	
	
	my $server_socket_ready = vec($rout, $socket_monitorado, 1);
	
	
		
		my $new_connection_socket;	
		accept($new_connection_socket, $server_socket) or die "Falha ao aceitar conexao: $!\n";	
		
		my $packed_socket_end = getpeername($new_connection_socket);
		
		#desempacotando $packed_socket_end com sockaddr_in()
		my ($client_port, $binary_client_ip) = sockaddr_in($packed_socket_end);
		
		my $client_ip = inet_ntoa($binary_client_ip);
		print "Cliente $client_ip se conectou pela porta $client_port em ". localtime(time) . "\n";
		
		
		#Armazenando o novo cliente no hash e identificando os clientes conectados

			id => $client_id,
			socket => $new_connection_socket,
			ip=> $client_ip,
			port => $client_port,
			buffer => ''	
			
		
		
		foreach my $key(keys %connected_clients) {
			my $client_info = $connected_clients{$key};
			print "Cliente $key: $client_info->{ip}:$client_info->{port}\n";
			
		print "\n";
		
		
		#escolhendo o filehandle do socket com select, para dar um autoflush	
		select($new_connection_socket);
		#configurando o filehandle selecionado para um autoflush
		$| = 1;
		#retornando para o filehandle original
		select(STDOUT);	

		
		
		
	#Back to Main loop
	
	
	
	foreach my $id (keys %connected_clients) {
		my $csocket = $connected_clients{$id}->{socket};		
		
		
		
		
			my $input;	
			my $bytes_read = sysread($csocket, $input, 1024);	
			
			
				if(!defined $connected_clients{$id}->{buffer}) {	$connected_clients{$id}->{buffer} = '';	}
				$connected_clients{$id}->{buffer} = $connected_clients{$id}->{buffer} . $input;
				
				# Verifica se há uma mensagem completa(termina em '\n')
				while($connected_clients{$id}->{buffer} =~ s/^(.*?\n)//) {
					my $complete_message = $1;
					print "Chegou em ". localtime(time) . " a mensagem do cliente $id: $complete_message";
					
					
						next if $other_client == $id;
						my $other_socket = $connected_clients{ $other_client}->{socket};
						print $other_socket "Cliente $id disse:$complete_message";
					
					}
				}
			} else {
				print "Cliente $id foi desconectado em " . localtime(time) . "\n";
				close $csocket;
				delete $connected_clients{$id};
				
				
				print "\nAgora temos conectados os clientes:\n";
				foreach my $key(keys %connected_clients) {
					my $client_info = $connected_clients{$key};
					print "Cliente $key: $client_info->{ip}:$client_info->{port}\n";
					
				}
				print "\n";
			}	
			
		}
	}	
