export const routes = [
  {
    path: "/",
    redirect: "/login",
  },
  {
    name: "login",
    path: "/login",
    meta: {
      isValidate: false,
    },
    component: () => import("@/components/Login.vue"),
  },
  {
    name: "index",
    path: "/index",
    meta: {
      isValidate: true,
    },
    component: () => import("@/views/Index.vue"),
    children: [
      {
        path: "/index",
        redirect: "/index/welcome",
      },
      {
        name: "welcome",
        path: "welcome",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/Welcome.vue"),
      },
      {
        name: "college",
        path: "college",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/college/Index.vue"),
      },
      {
        name: "studentInformationManagement",
        path: "studentInformationManagement",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/student/InformationManagement.vue"),
      },
      {
        name: "studentPermissionModification",
        path: "studentPermissionModification",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/student/PermissionModification.vue"),
      },
      {
        name: "taskInformationManagement",
        path: "taskInformationManagement",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/task/InformationManagement.vue"),
      },
      {
        name: "taskTypeManagement",
        path: "taskTypeManagement",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/task/TypeManagement.vue"),
      },
      {
        name: "adminAdministration",
        path: "adminAdministration",
        meta: {
          isValidate: true,
        },
        component: () => import("@/views/administrator/Index.vue"),
      },
    ],
  },
];
