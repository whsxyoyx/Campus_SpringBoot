import Vue from 'vue'
import VueRouter from 'vue-router'
import ArrPath from "@/router/arrPath";


Vue.use(VueRouter)

const routes = [
  //  '/'路径重定向到登录页面
  {
    path: '/',
    redirect: '/login',
  },
  {
    path: '/login',//登录
    name: 'login',
    component: () => import('../views/login/login.vue')
  },
  {
    path: '/home',//首页
    name: 'home',
    meta:{title:'首页'},
    component: () => import('../views/home/index.vue'),
    children:[
      {
        path:'/home/index',//首页
        name:'index',
        meta:{title:''},
        component:()=>import ('../views/home/index/index.vue')
      },
      {
        path:'/task',//任务管理
        name:'task',
        meta:{title:'任务管理'},
        component:()=>import ('../views/home/task/task.vue'),
        children:[
          {
            path:'/task/taskInfo',//任务信息
            name:'taskInfo',
            meta:{title:'任务信息管理'},
            component:()=>import ('../views/home/task/taskInfo.vue'),
          },
          {
            path:'/task/taskType',//添加任务
            name:'addTask',
            meta:{title:'任务类型管理'},
            component:()=>import ('../views/home/task/taskType.vue')
          },
        ]
      },
      {
        path:'/user',//学生管理
        name:'user',
        meta:{title:'学生管理'},
        component:()=>import ('../views/home/user/user.vue'),
        children:[
          {
            path:'/user/userInfo',//学生信息管理
            name:'userInfo',
            meta:{title:'学生信息管理'},
            component:()=>import ('../views/home/user/userInfo.vue')

          },
          {
            path:'/user/userRoot',//学生权限修改
            name:'userRoot',
            meta:{title:'学生权限修改'},
            component:()=>import ('../views/home/user/userRoot.vue')
          },
        ]
      },

      {
        path:'/school',//学院管理
        name:'school',
        meta:{title:'学院管理'},
        component:()=>import ('../views/home/school/school.vue')
      },
      {
        path:'/admin',//管理员管理
        name:'admin',
        meta:{title:'管理员管理'},
        component:()=>import ('../views/home/admin/admin.vue')
      }
    ]
  }

]

const router = new VueRouter({
  routes
})
//设置全局前置守卫
router.beforeEach((to, from, next) => {
  //每次路由请求的路径在arrPath数组里面存在，就判断用户是否有访问权限
  console.log(ArrPath.indexOf(to.path)!=-1)
  if (ArrPath.indexOf(to.path)!=-1){
    const token=sessionStorage.getItem('currentAdminAccount')
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
