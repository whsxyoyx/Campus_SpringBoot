import Cookies from 'js-cookie'


const TokenKey = "app-token"

// 从cookies中调取保存的后台访问令牌
export function getToken() {
    return Cookies.get(TokenKey)
}

// 在登录成功后将后台访问令牌存储在cookie中
export function setToken(token, rememberMe) {
    if (rememberMe) {
        return Cookies.set(TokenKey, token, { expires: 1 })
    } else return Cookies.set(TokenKey, token)
}

export function removeToken() {
    return Cookies.remove(TokenKey)
}
