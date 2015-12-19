import requests
import re
import itertools
from sys import argv

def get_data(url):

    print url
    r = requests.get(url)
    html = r.content
    atbat_list = re.findall("(<atbat[\s\S]*?</atbat)", html)
    for bat in atbat_list:
        try:
            batter = re.findall('batter="([^"]*)', bat)[0].strip()
            batter_hand = re.findall('stand="([^"]*)', bat)[0].strip()
            pitcher = re.findall('pitcher="([^"]*)', bat)[0].strip()
            pitcher_hand = re.findall('p_throws="([^"]*)', bat)[0].strip()
            event = re.findall('event="([^"]*)', bat)[0].strip()
            pitch_list = re.findall("(<pitch[\s\S]*?/>)", bat)
            for pit in pitch_list:
                data = ''
                data = '{},{},{},{},{}'.format(batter, batter_hand, pitcher, pitcher_hand,event)
                typ = re.findall('type="([^"]*)', pit)[0]
                x = re.findall('x="([^"]*)', pit)[0]
                y = re.findall('y="([^"]*)', pit)[0]
                start_speed = re.findall('start_speed="([^"]*)', pit)[0]
                end_speed = re.findall('end_speed="([^"]*)', pit)[0]
                sz_top = re.findall('sz_top="([^"]*)', pit)[0]
                sz_bot = re.findall('sz_bot="([^"]*)', pit)[0]
                pfx_x = re.findall('pfx_x="([^"]*)', pit)[0]
                pfx_z = re.findall('pfx_z="([^"]*)', pit)[0]
                px = re.findall('px="([^"]*)', pit)[0]
                pz = re.findall('pz="([^"]*)', pit)[0]
                x0 = re.findall('x0="([^"]*)', pit)[0]
                y0 = re.findall('y0="([^"]*)', pit)[0]
                z0 = re.findall('z0="([^"]*)', pit)[0]
                vx0 = re.findall('vx0="([^"]*)', pit)[0]
                vy0 = re.findall('vy0="([^"]*)', pit)[0]
                vz0 = re.findall('vz0="([^"]*)', pit)[0]
                ax = re.findall('ax="([^"]*)', pit)[0]
                ay = re.findall('ay="([^"]*)', pit)[0]
                az = re.findall('az="([^"]*)', pit)[0]
                break_y = re.findall('break_y="([^"]*)', pit)[0]
                break_angle = re.findall('break_angle="([^"]*)', pit)[0]
                break_length = re.findall('break_length="([^"]*)', pit)[0]
                pitch_type = re.findall('pitch_type="([^"]*)', pit)[0]
                spin_dir = re.findall('spin_dir="([^"]*)', pit)[0]
                spin_rate = re.findall('spin_rate="([^"]*)', pit)[0]
                ans = '{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}'.format(url,data,typ,
                                                    x,y,start_speed,end_speed,sz_top,sz_bot,
                                                    pfx_x,pfx_z,px,pz,x0,y0,z0,vx0,vy0,vz0,
                                                    ax,ay,az,break_y,break_angle,break_length,
                                                    pitch_type,spin_dir,spin_rate)

                with open(output_file, 'a') as fil:
                    fil.write(ans + '\n')
        except Exception, ee:
            pass


def extract_data(url):

    try:
        r = requests.get(url)
        html = r.content
        links = re.findall('"(gid_[^"]*)', html)
        for link in links:
            page_url = url + link + 'inning/inning_all.xml'
            get_data(page_url)
    except Exception, r:
        pass


def start():
    """
    """
    month = range(1, 13)
    days = range(1, 32)
    combo = itertools.product(month, days)
    for i, j in combo:
        i = str(i).zfill(2)
        j = str(j).zfill(2)
        new_url = '{}/month_{}/day_{}/'.format(url, i, j)
        extract_data(new_url)


if __name__ == '__main__':
    # start of program
    year = argv[1]
    output_file = argv[2]
    url = 'http://gd2.mlb.com/components/game/mlb/year_{}'.format(year)
    with open(output_file, 'a') as fil:
        fil.write('url,batter,batter_hand,pitcher,pitcher_hand,event,type,x,y,start_speed,end_speed,sz_top,sz_bot,pfx_x,pfx_z,px,pz,x0,y0,z0,vx0,vy0,vz0,ax,ay,az,break_y,break_angle,break_length,pitch_type,spin_dir,spin_rate\n')
    start()
