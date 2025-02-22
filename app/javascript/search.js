document.addEventListener("turbo:load", function () {
    const searchForm = document.getElementById("search-form");
  
    if (searchForm) {
      const searchInput = document.getElementById("search-input");
      const categorySelect = document.getElementById("category-select");
  
      function triggerSearch() {
        Rails.fire(searchForm, "submit");
      }
  
      let debounceTimeout;
  
      searchInput.addEventListener("input", () => {
        clearTimeout(debounceTimeout);
        debounceTimeout = setTimeout(triggerSearch, 300);
      });
  
      categorySelect.addEventListener("change", triggerSearch);
    }
  });
  