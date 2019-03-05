import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private int bombC = 30;

void setup ()
{
    bombs = new ArrayList<MSButton>();
    size(500, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    
    setBombs();
}
public void setBombs()
{

    for(int r = 0; r < bombC; r++){
        int br = (int)(Math.random()*20);
        int bc = (int)(Math.random()*20);
        if(bombs.contains(buttons[bc][br]) == false){
            bombs.add(buttons[bc][br]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int mc = 0;
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].isMarked() == true && bombs.contains(buttons[r][c])){
                mc++;
                if(mc == bombC){
                    return true;
                }
            }
        }
    }
    return false;
}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].isClicked() == true && bombs.contains(buttons[r][c])){
                buttons[10][6].setLabel("Y");
                buttons[10][7].setLabel("O");
                buttons[10][8].setLabel("U");
                buttons[10][10].setLabel("L");
                buttons[10][11].setLabel("O");
                buttons[10][12].setLabel("S");
                buttons[10][13].setLabel("E");
               
            }
        }
    }
}
public void displayWinningMessage()
{
    if(isWon() == true){
        buttons[10][6].setLabel("Y");
        buttons[10][7].setLabel("O");
        buttons[10][8].setLabel("U");
        buttons[10][10].setLabel("W");
        buttons[10][11].setLabel("I");
        buttons[10][12].setLabel("N");
        buttons[10][13].setLabel("!");
    }

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 500/NUM_COLS;
        height = 500/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
        {
            if(marked == false)
            {
                marked = true;
            }
            else if (marked == true)
            {
                clicked = false;
                marked =  false;     
            }
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage(); 
        }
        else if (countBombs(r,c) > 0) 
        {
            setLabel("" + countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            {
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            {
                buttons[r-1][c+1].mousePressed();
            }
            
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row-1,col) == true && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if (isValid(row+1,col) == true && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
         if (isValid(row,col-1) == true && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
         if (isValid(row,col+1) == true && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
         if (isValid(row-1,col+1) == true && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
         if (isValid(row-1,col-1) == true && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
         if (isValid(row+1,col+1) == true && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }
         if (isValid(row+1,col-1) == true && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        return numBombs;
    }
}



