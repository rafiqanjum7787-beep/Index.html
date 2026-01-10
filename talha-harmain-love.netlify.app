// -------------------- GLOBAL CONTROLS --------------------
const bgMusic = document.getElementById("bgMusic");

// -------------------- LOCK --------------------
function unlock() {
    const passValue = document.getElementById("pass").value.toLowerCase();
    if (passValue === "talha" || passValue === "harmain") {
        document.getElementById("lock").style.display = "none";
        document.getElementById("game").style.display = "block";
        bgMusic.play();
        startGame();
    } else {
        document.getElementById("err").innerText = "Try again, hint: Your names? ❤️";
    }
}

// -------------------- HEART GAME --------------------
let score = 0;
function startGame() {
    const area = document.getElementById("heart-area");
    let interval = setInterval(() => {
        if (score >= 10) {
            clearInterval(interval);
            setTimeout(startQuiz, 1000);
            return;
        }
        let h = document.createElement("span");
        h.innerHTML = ["❤️", "💖", "💙", "💕"][Math.floor(Math.random() * 4)];
        h.style.left = Math.random() * 90 + "vw";
        h.onclick = () => {
            score++;
            document.getElementById("score").innerText = score;
            h.remove();
        };
        area.appendChild(h);
        setTimeout(() => h.remove(), 4000);
    }, 800);
}

// -------------------- QUIZ --------------------
const questions = [
    { q: "Who misses you the most right now?", a: "talha" },
    { q: "What color is our love?", a: "blue" }
];
let currentQ = 0;

function startQuiz() {
    document.getElementById("game").style.display = "none";
    document.getElementById("quizPage").style.display = "block";
    showQuestion();
}

function showQuestion() {
    document.getElementById("quizQuestion").innerText = questions[currentQ].q;
    document.getElementById("quizAnswer").value = "";
}

function nextQuiz() {
    let ans = document.getElementById("quizAnswer").value.toLowerCase();
    if (ans.includes(questions[currentQ].a)) {
        currentQ++;
        if (currentQ < questions.length) {
            showQuestion();
        } else {
            showLetter();
        }
    } else {
        document.getElementById("quizMessage").innerText = "Think harder! ❤️";
    }
}

// -------------------- LETTER --------------------
function showLetter() {
    document.getElementById("quizPage").style.display = "none";
    document.getElementById("letterPage").style.display = "block";
    const text = "Every second feels like an hour when you're not around. This little page is just a reminder that Talha is always thinking of Harmain. I miss your smile, your voice, and everything about us. 💙";
    let i = 0;
    function type() {
        if (i < text.length) {
            document.getElementById("letterText").innerHTML += text.charAt(i);
            i++;
            setTimeout(type, 50);
        }
    }
    type();
}

// -------------------- MEMORY GAME --------------------
const icons = ["💙", "💙", "💖", "💖", "🌹", "🌹", "💍", "💍"];
let flipped = [];
function showMemory() {
    document.getElementById("letterPage").style.display = "none";
    document.getElementById("memoryGame").style.display = "block";
    let shuffled = icons.sort(() => Math.random() - 0.5);
    const board = document.getElementById("memoryBoard");
    shuffled.forEach((icon, index) => {
        let card = document.createElement("div");
        card.dataset.icon = icon;
        card.innerHTML = "?";
        card.onclick = () => {
            if (flipped.length < 2 && !card.classList.contains('found')) {
                card.innerHTML = icon;
                flipped.push(card);
                if (flipped.length === 2) {
                    if (flipped[0].dataset.icon === flipped[1].dataset.icon) {
                        flipped.forEach(c => c.classList.add('found'));
                        flipped = [];
                    } else {
                        setTimeout(() => {
                            flipped.forEach(c => c.innerHTML = "?");
                            flipped = [];
                        }, 500);
                    }
                }
            }
        };
        board.appendChild(card);
    });
}

// -------------------- FINAL CANVAS --------------------
function showFinalPage() {
    document.getElementById("memoryGame").style.display = "none";
    document.getElementById("finalPage").style.display = "block";
    const canvas = document.getElementById("finalCanvas");
    const ctx = canvas.getContext("2d");
    let t = 0;

    function draw() {
        ctx.fillStyle = "rgba(10, 10, 35, 0.1)";
        ctx.fillRect(0, 0, 700, 700);
        ctx.translate(350, 350);
        
        for (let i = 0; i < 50; i++) {
            let x = 16 * Math.pow(Math.sin(t), 3);
            let y = -(13 * Math.cos(t) - 5 * Math.cos(2 * t) - 2 * Math.cos(3 * t) - Math.cos(4 * t));
            ctx.fillStyle = `hsl(${t * 50}, 100%, 70%)`;
            ctx.fillRect(x * 15, y * 15, 4, 4);
            t += 0.1;
        }
        ctx.setTransform(1, 0, 0, 1, 0, 0);
        requestAnimationFrame(draw);
    }
    draw();
}
</script>
