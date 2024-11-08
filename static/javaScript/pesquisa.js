const searchInput = document.getElementById('pesquisa-input');
const submitButton = document.querySelector('button[type="submit"]');
const resultadoDiv = document.getElementById('resultado');
let timeout;

const search = () => {
    const searchTerm = searchInput.value.trim();
    
    if (searchTerm !== '') {
        fetch(`/pesquisar?termo=${encodeURIComponent(searchTerm)}`)
            .then(response => response.json())
            .then(data => {
                if (data.length > 0) {
                    resultadoDiv.innerHTML = data.map(item => `<div class="resultado-item">${item}</div>`).join('');
                } else {
                    resultadoDiv.innerHTML = '<div class="nenhum-resultado">Nenhum resultado encontrado</div>';
                }
            })
            .catch(error => {
                console.error('Erro ao realizar a busca:', error);
                resultadoDiv.innerHTML = '<div class="erro">Erro na busca. Tente novamente mais tarde.</div>';
            });
    } else {
        resultadoDiv.innerHTML = ''; // Limpa os resultados se o termo de pesquisa estiver vazio
    }
};

searchInput.addEventListener('input', () => {
    clearTimeout(timeout); // Limpa o timeout anterior
    timeout = setTimeout(() => {
        search(); // Chama a função de busca após 300ms
    }, 300);
});

submitButton.addEventListener('click', (e) => {
    e.preventDefault(); // Impede o envio do formulário
    search(); // Chama a função de busca quando o botão é clicado
});

resultadoDiv.addEventListener('click', () => {
    resultadoDiv.innerHTML = ''; // Limpa os resultados ao clicar no div
    searchInput.value = ''; // Limpa o campo de pesquisa
});