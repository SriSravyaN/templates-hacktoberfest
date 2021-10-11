import random
import sys

suits = ('Hearts', 'Diamonds', 'Spades', 'Clubs')
ranks = ('Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King', 'Ace')
values = {'Two':2, 'Three':3, 'Four':4, 'Five':5, 'Six':6, 'Seven':7, 'Eight':8, 'Nine':9, 'Ten':10, 'Jack':10,
         'Queen':10, 'King':10, 'Ace':11}

class Card:
    def __init__(self, suit, rank):
        self.rank = rank
        self.suit = suit
        
    def __str__(self):
        return self.rank+" of "+self.suit  #names the card when asked to print it.

class Deck:
    def __init__(self):
        self.deck=[]
        for i in suits:
            for j in ranks:
                self.deck.append(Card(i,j)) #instanciates the Card class.
    def shuffle(self):
        #This function shuffles the the deck.
        random.shuffle(self.deck)

class distribute:
    def __init__(self):
        self.playcards=[]
        self.value=0
        self.ace=0

    def add_card(self,card):
        self.playcards.append(card) #list of cards which are distributed to the players
        self.value+=values[card.rank]
        #below block of code check for the variation in Ace. 
        if card.rank=="Ace":
            self.ace+=1 #counts the number of Aces in the player's/dealer's hand
        if self.ace>0 and self.value>21:
            self.value-=10 #will assign the value 1 to Ace if the final value exceeds 21
            self.ace-=1

def bet_input():
    #Will ensure that the bet amount is in proper format.
    while 1:
        try:
            bet=int(input("Enter your bet: "))
        except:
            print("Please enter an integer value")
        else:
            if bet<10:
                print("Minimum bet is 10")
            elif bet>chips:
                print("Bet amount exceeded available chips")
            else:
                return bet

def display_hit():
    #displays the final standing result including the final value.
    print("\nDealer hand : ")
    for i,j in enumerate(dealer_hand.playcards):
        if i==1:
            print("<Card-Hidden>") #Hides the 2nd card of the dealer.
            continue
        print(j)
    print("\nPlayer hand : ")
    for i in player_hand.playcards:
        print(i)
    print("Player value :", player_hand.value)

def display():
    #displays the final standing result including the final value.
    print("\nDealer hand : ")
    for i in dealer_hand.playcards:
        print(i)
    print("Dealer value :", dealer_hand.value)
    print("\nPlayer hand : ")
    for i in player_hand.playcards:
        print(i)
    print("Player value :", player_hand.value)

def dealer_hit(obj):
    global flag
    #dealer keeps on picking the cards until the final value exceeds 17
    while obj.value<17:
        obj.add_card(d.deck.pop())
    if obj.value>21: #if value>21, dealer will get bust
        print("Dealer bust")
        flag=2

print("Welcome to War BlackJack!")
if input("Want Manual?(y/n) ").lower()=="y":
    print("\nHow to play BlackJack:")
    print("Dealer will distribute 2 cards to player and will keep one card with herself.")
    print("All Number cards will have value corresponding to its number")
    print("All Face cards will have value 10")
    print("Aces can have value either 1 or 11 depending on the situation")

    print("THE AIM IS TO KEEP THE VALUE AS CLOSE TO 21 AS POSSIBLE ")
    print("If player's value exactly matches 21, that is a BLACKJACK! and the player will be rewarded 150% of the bet amount")
    print("If player's value is greater than the dealer's value, given that the value is not exceeding 21, the player is awarded 100% of the bet amount")
    print("If draw, the bet is returned")
    print("If value exceeds 21, this is BUST and the player lose")

    print("-"*20)
    print("About hitting and standing:")
    print("If player opts to hit, he will be given another card")
    print("If player opts to stand, dealer will keep on picking the cards until her final value exceeds 17")
    print("If the value of dealer exceeds 21 when player stands, the player wins")
    print("*"*20)
    print("\nHow to play War:")
    print("Player and dealer, both will be given a card")
    print("Whoever's card value is greater, wins")
play=True
chips=100
while play:
    if chips<0:
        print("No chips available")
        print("Thank you for playing")
        break
    flag=1
    print(f"\nYou have {chips} chips")
    bet = bet_input()
    chips-=bet
    d=Deck()  #creates a fresh deck
    d.shuffle() #randomly shuffles the newly created deck.
    if input("Want to shuffle again?(y/n) ")=="y":
        d.shuffle()
    player_hand = distribute() #Creates a player profile
    player_hand.add_card(d.deck.pop()) #Provides 1st card to player.
    
    dealer_hand = distribute() #creates the dealer profile
    dealer_hand.add_card(d.deck.pop()) #Provides 1st card to dealer.
    
    
    #If opts for WAR
    if chips<10:
        print("Minimum requirement not satisfied for WAR")
    elif input("Want to war?(y/n) ").lower()=="y":
        bet1=bet_input()
        chips-=bet1

        if player_hand.value > dealer_hand.value:
            display()
            print("You won the War!")
            chips+=(2*bet1)
        elif player_hand.value < dealer_hand.value:
            display()
            print("You lost the War")
        else:
            display()
            print("Draw")
            chips+=bet1
        print("\nAvailable chips :",chips)

    player_hand.add_card(d.deck.pop()) #Provides 2nd card to player.
    dealer_hand.add_card(d.deck.pop()) #Provides 2nd card to dealer(hidden)

    cont=True 
    if dealer_hand.value==21:
        print("\nYou lose, Dealer's blackjack!")
        display()
        if chips<10:
            print("Not enough coins! minimum equirement is 10")
            print("Thank you for playing")
            print("Chips in-hand:",chips)
            break
        elif input("want to continue?(y/n)").lower()!="n":
            continue
        else:
            print("Thank you for playing")
            break
    
    display_hit() #shows the card which was distributed.
    # below while loop runs the hit/stand functionality until either the players busts or if he/she opts to stand. (Also checking for valid input)
    while cont:
        choice = input("\nEnter H to hit or Enter S to stand: ").lower()
        if choice=="h": #if player opts for hit
            player_hand.add_card(d.deck.pop()) #provides another card to player
            display_hit() #displays newly distributed sets.
            if player_hand.value>21:
                print("You Bust")
                flag=0
                cont=False

        elif choice=="s": #if player opts for stand
            cont=False
            dealer_hit(dealer_hand) #dealer will pick the cards now.
            display() #display the new distribution along with final value 
        else:
            print("Enter valid input!")

    if flag==1:
        if player_hand.value==21:
            print("Blackjack!")
            #if the player value equals 21, the player will be getting 150% of the bet amount. (excluding the original bet)
            chips+=int(2.5*bet) #bet_amount + (bet_amount*1.5)
        elif dealer_hand.value > player_hand.value:
            print("You Lose")
        elif dealer_hand.value < player_hand.value:
            #if the player wins, he/she will be getting 100% of the bet amount. (excluding the original bet)
            print("You win") #bet_amount + (bet_amount*1.0)
            chips+=int(2*bet)
        else:
            print("Draw") #if draw, bet amount is returned
            chips+=bet
            
    elif flag==2:
        if player_hand.value==21:
            print("Blackjack!")
            #if the player value equals 21, the player will be getting 150% of the bet amount. (excluding the original bet)
            chips+=int(2.5*bet) #bet_amount + (bet_amount*1.5)
        elif dealer_hand.value > player_hand.value:
            #if the player wins, he/she will be getting 100% of the bet amount. (excluding the original bet)
            print("You win") #bet_amount + (bet_amount*1.0)
            chips+=int(2*bet)
    print("Available chips:", chips)


    if chips<10:
        print("Not enough coins! minimum equirement is 10")
        print("Thank you for playing")
        print("Chips in-hand:",chips)
        break

    elif input("Want to continue?(y/n)").lower()=="n": #asks the player if he/she wants to continue or not.
        print("Thank you for playing")
        break