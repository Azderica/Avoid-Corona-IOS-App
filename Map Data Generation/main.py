
# -*- coding: utf-8 -*-
import requests

print('o0epgG67W%2FU%2BuVk%2FYH%2Fsb%2BvsH0Oknwv9zCuTO%2BG5K4r0n8I%2FzV6WUZ0eh2wmtPZjmhCd12L5D3W5C%2F3OoqT%2BFg%3D%3D')

serviceKey = 'o0epgG67W%2FU%2BuVk%2FYH%2Fsb%2BvsH0Oknwv9zCuTO%2BG5K4r0n8I%2FzV6WUZ0eh2wmtPZjmhCd12L5D3W5C%2F3OoqT%2BFg%3D%3D'
url = 'http://openapi.tago.go.kr/openapi/service/BusSttnInfoInqireService/getSttnNoList'

print('Browser url:')
browserurl = "http://openapi.tago.go.kr/openapi/service/BusSttnInfoInqireService/getSttnNoList?serviceKey=o0epgG67W%2FU%2BuVk%2FYH%2Fsb%2BvsH0Oknwv9zCuTO%2BG5K4r0n8I%2FzV6WUZ0eh2wmtPZjmhCd12L5D3W5C%2F3OoqT%2BFg%3D%3D&cityCode=25&nodeNm=전통시장&nodeNo=44810&numOfRows=10&pageNo=1&"
print("http://openapi.tago.go.kr/openapi/service/BusSttnInfoInqireService/getSttnNoList?serviceKey=o0epgG67W%2FU%2BuVk%2FYH%2Fsb%2BvsH0Oknwv9zCuTO%2BG5K4r0n8I%2FzV6WUZ0eh2wmtPZjmhCd12L5D3W5C%2F3OoqT%2BFg%3D%3D&cityCode=25&nodeNm=전통시장&nodeNo=44810&numOfRows=10&pageNo=1&")
print('Python url')

r = requests.get(browserurl)
print(r.text)
print(r.json())