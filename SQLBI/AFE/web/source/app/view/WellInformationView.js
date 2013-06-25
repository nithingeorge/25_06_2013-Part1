/* 
 *
 * 
 */

Ext.define('AFE.view.WellInformationView',
{
    extend:'Ext.panel.Panel',
    alias:'widget.wellInformationView',

    initComponent: function() {
        this.layout={
            type: 'vbox'
        };
        this.items=[
        {
            baseCls:'contentHeader',
            flex:1,
            width:'100%',
            layout: {
                type: 'hbox',
                pack: 'start',
                align: 'middle'
            },
            items:[
            {
                xtype:'panel',
                layout:{
                    type:'hbox'
                },
                items:[ 
                    {
                    //                    flex:1,
                    width:'2%',
                    border:false,
                    bodyStyle:'background:transparent;color:white'
                    
                },{
                   
                    bodyStyle:'background:transparent;color:white',
                    border:false,
                    items:[ {
                        xtype:'label' ,
                        text:'Well Information'
                   
                    }],
                    flex:4
                },
                {
                   
                    bodyStyle:'background:transparent;color:white',
                    border:false,
                    items:[ {
                        xtype:'label' ,
                        text:'1/1/2012 - 6/30/2012',
                        
                        cls:'titleDate'
                    }],
                    flex:25
                }
                

                ],
                flex:1,
                border:false,
                bodyStyle:'background:transparent;color:white'
            }


            ]
        },
        {

            flex:6,
            border:false,
            width:'100%' ,
            layout:{
                type:'hbox',
                align:'stretch'
               
            },
            items:[
            {
                xtype:'panel',
                border:false,
                width:'50%',
                flex:1,
                layout:{
                    type:'vbox',
                    align:'center'
                },
                items:[
                {
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Well Name : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'Barnes 03-01',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                    
                },
                {
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Unit Lease : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'Barnes 03',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                    
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        border:false,
                        flex:1,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'SubArea : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'PB-Fairview',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Area : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'PB-East Wolfberry OP',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Working Interest : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'1.00',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Oil NRI : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'50%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'0.86',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                }
                ]
            },
            {
                xtype:'panel',
                border:false,
                width:'50%',
                flex:1 ,
                layout:{
                    type:'vbox',
                    align:'center'
                },
                items:[
                {
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'API : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'42-227-36278-00',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                  
                    
                },
                {
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                     layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'District : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'PB-Texas Op',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                    layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Business Unit : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'Permian Basin TX',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                     layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Operated : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'Yes',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                    border:false,
                    width:'100%',
                    flex:1,
                     layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'SPUD Date : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'12/20/2010',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                },{
                    xtype:'panel',
                                border:false,
                    width:'100%',
                    flex:1,
                     layout:
                    {
                        type:'hbox',
                        align:'stretch'
                    },
                    items:[
                    {
                        width:'30%',
                        flex:1,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'end',
                            align:'middle'
                        },
                        items:[  
                        {
                            xtype:'label',
                            text:'Gas NRI : ',
                            cls:'wellSearchLabel'
                        }
                        ]
                    },
                    {
                        width:'70%',
                        flex:2,
                        border:false,
                        layout:{
                            type:'hbox',
                            pack:'start',
                            align:'middle'
                        },
                        items:[  
                        {
                            border:false,
                            xtype: 'label',
                            text:'0.86',
                            cls:'wellSearchLabelContent'
                        }
                        ]
                    }
                    ]
                }
                ]
            }
            ]
            
        

        }
        ];
        this.callParent(arguments);
    }
});