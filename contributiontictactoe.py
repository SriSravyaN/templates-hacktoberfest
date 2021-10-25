# MODULES
import pygame, sys
import numpy as np

# pygame initialisation
pygame.init()


# CONSTANTS

width = 600
height = 600
linewidth = 20
WIN_linewidth = 20
b_rows = 3
b_cols = 3
szize = 200
cradius = 60
cwidth = 15
crosswidth = 25
gap = 55
red = (255, 0, 0)
bgcolour = (156, 170, 156)
linecolour = (100, 145, 135)
ccolour = (156, 231, 200)
crosscolour = (100,100, 66)


# SCREEN

screen = pygame.display.set_mode( (width, height) )
pygame.display.set_caption( 'TicTacToe' )
screen.fill( bgcolour )


# BOARD

board = np.zeros( (b_rows, b_cols) )


# FUNCTIONS

def drawline():
	# 1 horizontal
	pygame.draw.line( screen, linecolour, (0,szize), (width, szize), linewidth )
	# 2 horizontal
	pygame.draw.line( screen, linecolour, (0, 2 * szize), (width, 2 * szize), linewidth )

	# 1 vertical
	pygame.draw.line( screen, linecolour, (szize, 0), (szize, height), linewidth )
	# 2 vertical
	pygame.draw.line( screen, linecolour, (2 * szize, 0), (2 * szize, height), linewidth )

def figuredraw():
	for row in range(b_rows):
		for col in range(b_cols):
			if board[row][col] == 1:
				pygame.draw.circle( screen, ccolour, (int( col * szize + szize//2 ), int( row * szize + szize//2 )), cradius, cwidth )
			elif board[row][col] == 2:
				pygame.draw.line( screen, crosscolour, (col * szize + gap, row * szize + szize - gap), (col * szize + szize - gap, row * szize + gap), crosswidth )	
				pygame.draw.line( screen, crosscolour, (col * szize + gap, row * szize + gap), (col * szize + szize - gap, row * szize + szize - gap), crosswidth )

def markbox(row, col, player):
	board[row][col] = player

def available_square(row, col):
	return board[row][col] == 0

def checkboardfull():
	for row in range(b_rows):
		for col in range(b_cols):
			if board[row][col] == 0:
				return False

	return True

def checkwin(player):
	# vertical win check
	for col in range(b_cols):
		if board[0][col] == player and board[1][col] == player and board[2][col] == player:
			columnwincheck(col, player)
			return True

	# horizontal win check
	for row in range(b_rows):
		if board[row][0] == player and board[row][1] == player and board[row][2] == player:
			rowwincheck(row, player)
			return True

	# asc diagonal win check
	if board[2][0] == player and board[1][1] == player and board[0][2] == player:
		maindiawincheck(player)
		return True

	# desc diagonal win chek
	if board[0][0] == player and board[1][1] == player and board[2][2] == player:
		seconddiawincheck(player)
		return True

	return False

def columnwincheck(col, player):
	posX = col * szize + szize//2

	if player == 1:
		color = ccolour
	elif player == 2:
		color = crosscolour

	pygame.draw.line( screen, color, (posX, 15), (posX, height - 15), linewidth )

def rowwincheck(row, player):
	posY = row * szize + szize//2

	if player == 1:
		color = ccolour
	elif player == 2:
		color = crosscolour

	pygame.draw.line( screen, color, (15, posY), (width - 15, posY), WIN_linewidth )

def maindiawincheck(player):
	if player == 1:
		color = ccolour
	elif player == 2:
		color = crosscolour

	pygame.draw.line( screen, color, (15, height - 15), (width - 15, 15), WIN_linewidth )

def seconddiawincheck(player):
	if player == 1:
		color = ccolour
	elif player == 2:
		color = crosscolour

	pygame.draw.line( screen, color, (15, 15), (width - 15, height - 15), WIN_linewidth )

def restart():
	screen.fill( bgcolour )
	drawline()
	for row in range(b_rows):
		for col in range(b_cols):
			board[row][col] = 0

drawline()


# VARIABLES

player = 1
game_over = False


# MAIN

while True:
	for event in pygame.event.get():
		if event.type == pygame.QUIT:
			sys.exit()

		if event.type == pygame.MOUSEBUTTONDOWN and not game_over:

			mouseX = event.pos[0] # x
			mouseY = event.pos[1] # y

			rowclicked = int(mouseY // szize)
			columnclicked = int(mouseX // szize)

			if available_square( rowclicked, columnclicked ):

				markbox( rowclicked, columnclicked, player )
				if checkwin( player ):
					game_over = True
				player = player % 2 + 1

				figuredraw()

		if event.type == pygame.KEYDOWN:
			if event.key == pygame.K_r:
				restart()
				player = 1
				game_over = False

	pygame.display.update()