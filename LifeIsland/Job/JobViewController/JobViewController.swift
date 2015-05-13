//
//  JobViewController.swift
//  LifeIsland
//
//  Created by Caesar on 15/5/8.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit

let XianQingHeight:CGFloat = 50
class JobViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource ,UIScrollViewDelegate{
    var Switch:Bool = true //详情锁
    var Switch1:Int = 0 //详情锁
    var CellHight = Dictionary<Int,CGFloat>()//记录每一个cell的高度
    @IBOutlet var JobView: UITableView!
    

    @IBOutlet var JobCell: JobTableViewCell!
    
    var dataSource:[OrderModel]?

    //详情按钮
    @IBAction func XiangQingAction(sender: AnyObject) {
        
        var l:UIButton  = sender as! UIButton
        var cell:JobTableViewCell = self.tableView.viewWithTag(l.tag) as! JobTableViewCell
        println("\(l.tag)")
        if Switch1 == 0 || Switch1 == l.tag {
        if Switch {
        self.tableView.beginUpdates()
            
            
            
            var data:Array<GoodsModel>?  = self.dataSource![l.tag - 1000].items
            
            var increntHeight = (data!.count + 2)*25 + 10
        cell.frame.size.height += CGFloat(increntHeight)
        
        var orderCodeUL = UILabel(frame:CGRect(x: 20, y: 5, width: 200, height: 15))
        orderCodeUL.text =  self.dataSource![l.tag-1000].orederCode
        cell.XiangQingView.addSubview(orderCodeUL)
            
        var source = UILabel(frame:CGRect(x: 20, y: 10+15+5, width:300, height: 15))
        source.text =  self.dataSource![l.tag-1000].source!+"#\(self.dataSource![l.tag-1000].number!)号订单"
        cell.XiangQingView.addSubview(source)
        if data!.count>0
        {
            for index in 0...(data!.count - 1)
            {
                var label = UILabel(frame:CGRect(x: 20, y: 55 + 25*index, width: 200, height: 15))
                label.font = UIFont.systemFontOfSize(13)
                label.text = "\(index+1)." + data![index].dishName!
                cell.XiangQingView.addSubview(label)

            }
        }
        CellHight.updateValue(cell.frame.size.height, forKey: l.tag-1000)//在字典里更新高度
            
            
            
        self.tableView.endUpdates()
        Switch = false
            Switch1 = l.tag
        }
        else{
            self.tableView.beginUpdates()
     
            
            cell.frame.size.height = 118
            CellHight.updateValue(cell.frame.size.height, forKey: l.tag-1000)
            self.tableView.endUpdates()
            
           for view in  cell.XiangQingView.subviews
            {
                if view is UILabel
                {
                    (view as! UILabel).removeFromSuperview()
                }
            }
            Switch = true
            Switch1 = 0
        }
        }

    }
    
    //更多 按钮
    @IBAction func MoreAction(sender: AnyObject) {
        let nextViewController  = MoreViewController(nibName:"MoreViewController",bundle:nil)
        self.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(nextViewController, animated: true, completion: nil)
    
    }
    
    
    @IBOutlet var SaoMiao: UIButton!
    
    @IBAction func SaoMiaoAction(sender: AnyObject) {
        let nextViewController  = TDCViewController();
        nextViewController.hidesBottomBarWhenPushed = true
         self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    var buttonY:CGFloat?//记录初始的扫描图标的高度

    
    
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "工作岗位"
        //代理
       JobView.delegate = self
      JobView.dataSource = self
        
        //设置扫描图标
        var frame = UIScreen.mainScreen().bounds
        SaoMiao.frame = CGRectMake(frame.size.width-70, frame.size.height-70, 60,60)
        JobView.addSubview(SaoMiao)
    
    JobView.bringSubviewToFront(SaoMiao)
        buttonY = SaoMiao.frame.origin.y
        
        
        
        
        var dataMg = DataManager.getInstance
        var userMg = UserManager.getInstance
        //获得缓存的数据
        if  dataMg.GetOrderFromCache()
        {
            dataSource =  dataMg.ordersArr
        }
        
       NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("getOrderData"), name:UPDateUSERORDER, object:nil)
        
        
       dataMg.getAllOrders(userMg.user?.userName, userId:"\(userMg.user?.id)", offset:0)
        
        //给高度词典初始化
        for var i=0;i<dataSource?.count;i=i+1{
            CellHight[i] = 118
        }

    }
    
    
    override func  viewWillAppear(animated: Bool) {
        self.getOrderData()
    }
    
    func getOrderData()
    {
        dataSource = DataManager.getInstance.ordersArr
        for var i=0;i<dataSource?.count;i=i+1{
            CellHight[i] = 118
        }
        self.JobView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       //根据高度字典返回高度
        return CellHight[indexPath.row]!
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
//         Return the number of rows in the section.
        if dataSource == nil
        {
            return 0
        }
        else{
        return dataSource!.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        
       //加载cell并设置重用
        var cell:JobTableViewCell?
       cell = tableView.dequeueReusableCellWithIdentifier("L") as? JobTableViewCell
        
        if cell == nil{
        var arry = NSBundle.mainBundle().loadNibNamed("JobTableViewCell", owner: self, options: nil)
        cell = arry[0] as? JobTableViewCell
        }
        
        //设置Tag
        cell?.XiangQing.tag = indexPath.row + 1000
        cell?.tag = indexPath.row + 1000
        
        cell?.addressLabel.text = dataSource![indexPath.row].address
        
            return cell!
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */


    // Override to support conditional rearranging of the table view.
    //可移动
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }

    //保持扫描按钮不动
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        print(SaoMiao.frame.origin.y  )
        SaoMiao.frame = CGRectMake(SaoMiao.frame.origin.x, buttonY!+self.tableView.contentOffset.y,SaoMiao.frame.size.width ,SaoMiao.frame.size.height )
          }
    
    //设置cell不能点击
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}

