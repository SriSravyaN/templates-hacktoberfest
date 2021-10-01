const counter = document.querySelector('#counter')
const btns = document.querySelectorAll('.btn')

let count = 0

btns.forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const styles = e.currentTarget.classList

		if (styles.contains('increase')) {
			count++
		} else if (styles.contains('decrease')) {
			count--
		} else {
			count = 0
		}

		if (count > 0) {
			counter.style.color = 'purple'
		}

		if (count < 0) {
			counter.style.color = 'blue'
		}

		if (count === 0) {
			counter.style.color = 'red'
		}

		counter.textContent = count
	})
})
