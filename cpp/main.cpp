#include <SFML/Graphics.hpp>
#include <optional>

// Usamos paso por referencia y corregimos la dirección de A y D
void handleMovement(sf::Transformable& entity, float speed) {
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::A)) entity.move({-speed, 0.f});
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::D)) entity.move({speed, 0.f});
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::W)) entity.move({0.f, -speed});
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Key::S)) entity.move({0.f, speed});
}

int main() {
    // Configuración inicial
    sf::RenderWindow window(sf::VideoMode({800, 600}), "SFML 3 - Clean Code");
    window.setFramerateLimit(60);

    sf::RectangleShape player({100.f, 100.f});
    player.setFillColor(sf::Color::Green);
    player.setOrigin({50.f, 50.f});
    player.setPosition({400.f, 300.f});

    sf::RectangleShape aña({10.f,10.f});
    aña.setFillColor(sf::Color::Green);
    aña.setOrigin({50.f, 50.f});
    aña.setPosition({400.f, 300.f});

    sf::View view(sf::FloatRect({0.f, 0.f}, {800.f, 600.f}));

    while (window.isOpen()) {
        // --- 1. PROCESAMIENTO DE EVENTOS ---
        while (const std::optional event = window.pollEvent()) {
            if (event->is<sf::Event::Closed>()) {
                window.close();
            }

            if (const auto* resized = event->getIf<sf::Event::Resized>()) {
                view.setSize({ static_cast<float>(resized->size.x), 
                               static_cast<float>(resized->size.y) });
            }
        }

        // --- 2. LÓGICA / ACTUALIZACIÓN ---
        handleMovement(player, 5.f);
        view.setCenter(player.getPosition());
        window.setView(view);

        // --- 3. DIBUJO ---
        window.clear(sf::Color(30, 30, 30));
        
         // Aplicamos la vista antes de dibujar
        
        window.draw(player);
        window.draw(aña);
        window.display();
    }

    return 0;
}