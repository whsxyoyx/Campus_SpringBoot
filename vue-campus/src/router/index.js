import Vue from 'vue'
import VueRouter from 'vue-router'
import arrPath from './arrPath.js'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: ()=>import('@/views/login/login.vue')
  },
  {
    path: '/',//首页
    meta: {title: '首页'},
    component: () => import('../views/home/index.vue'),
    children: [
      {
        path: '/home',//首页
        name: 'home',
        meta: {title: ''},
        component: () => import ('../views/home/main.vue')
      },
      {
        path:'/home/center',//任务中心
        name:'center',
        meta:{title:'任务中心'},
        component:()=>import ('../views/home/task/index'),
      },
      {
        path:"/home/taskDisplay",
        name:"Task",
        meta:{title:'任务中心'},
        component: ()=>import('../views/home/task/taskDisplay'),
        children:[
          {
            path:"taskInfo",
            name:"TaskInfo",
            meta:{title:'任务信息'},
            component: ()=>import('../views/home/task/taskInfo')
          }
        ]
      },
      //任务管理
      {
        path:'/task',
        name:'task',
        alwaysShow:true,
        meta:{title:'任务管理'},
        component:()=>import ('../views/home/task/task.vue'),
        children:[
          {
            path:'/task/addTask',//添加任务
            name:'addTask',
            meta:{title:'发布任务'},
            component:()=>import ('../views/home/task/addTask.vue')
          },
          {
            path:'/task/publicedTask',//已发布任务
            name:'PublicedTask',
            meta:{title:'已发布任务'},
            component:()=>import ('../views/home/task/publicedTask.vue'),
          },
          {
            path:'/task/acceptedTask',//已接受任务
            name:'AcceptedTask',
            meta:{title:'已接受任务'},
            component:()=>import ('../views/home/task/acceptedTask.vue')
          },
        ]
      },
      //个人中心
      {
        path:'/user',
        name:'user',
        meta:{title:'个人中心'},
        component:()=>import ('../views/home/user/user.vue'),
        children:[
          {
            path:'/user/userInfo',//学生信息管理
            name:'userInfo',
            meta:{title:'学生信息管理'},
            component:()=>import ('../views/home/user/userInfo.vue')

          },
          {
            path:'/user/userPass',//学生密码修改
            name:'userPass',
            meta:{title:'学生密码修改'},
            component:()=>import ('../views/home/user/userPass.vue')
          },
          {
            path:'/user/userDaily',//学生日志管理
            name:'userDaily',
            meta:{title:'学生日志管理'},
            component:()=>import ('../views/home/user/userDaily.vue')
          },
        ]
      },

    ]
  }
]

const router = new VueRouter({
  routes
})
//设置全局前置守卫
router.beforeEach((to, from, next) => {
  //每次路由请求的路径在arrPath数组里面存在，就判断用户是否有访问权限
  console.log(arrPath.indexOf(to.path)!=-1)
  if (arrPath.indexOf(to.path)!=-1){
    const token=sessionStorage.getItem('currentUserId')
    if (token){
      next()
    }else{
      next('/login')
    }
  }else{
    next()
  }
})

export default router
