def handle_uploaded_file(f):
    linhas = []
    
    for chunk in f.chunks(): 
        for line in chunk.decode('utf-8').split('\n'):
            linhas.append(line)
        return linhas