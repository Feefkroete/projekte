public class drucktest
{
    public double dichte;
    
    public double Test(int x)
    {
        if(x<100)
        {
            dichte = -0.064301*x;
        }
        else
        {
            if(x>600)
            {
                dichte = -12;
            }
            else
            {
                if(x>250)
                {
                    dichte = -0.0057144*x-8.571;
                }
                else
                {
                    dichte = -1.4865e-6*x*x*x+9.642e-4*x*x-0.216275*x+7;
                }
            }
        }
        dichte = (12+dichte)/12;
        return dichte;
    }
}
