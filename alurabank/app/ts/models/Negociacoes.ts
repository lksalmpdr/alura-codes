class Negociacoes{

    private _negociacoes :Negociacao[] = []

    adiciona(negociacao :Negociacao){
        this._negociacoes.push(negociacao);
    }

    mostraArray(){
        return this._negociacoes;
    }
}