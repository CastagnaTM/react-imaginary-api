class UsersController < ApplicationController
    require 'faker'
  
    def index
        @users = User.all
        render json:@users
    end
    
    def login
        user = User.find_by(user_name: params['user_name'])
        if user && user.password == params['password']
            render json:{user: user}
        else
            render json:{errors: "Incorrect user name or password"}
        end
    end

    def create
        user = User.new(user_params)
        user.score = 0
        if user.save
            render json:{user: user}
        else
            render json:{errors: user.errors.full_messages}
        end
    end


    #logic for generating buddy info----
    def buddy_img_num_select
    a = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15].sample
    a
    end

    def buddy_prefs_create
    workout = '012'
    shopping = '345'
    eating = '678'
    prefs = ''
    prefs += workout[rand(3)]
    prefs += shopping[rand(3)]
    prefs += eating[rand(3)]
    prefs
    end

    def find_a_friend
        buddy = Buddy.create(name: Faker::Superhero.name, img_num: buddy_img_num_select(), prefs: buddy_prefs_create()) 
        user = User.all.find_by(id: params[:id])
        friendship = Friendship.create(user_id: user.id, buddy_id: buddy.id)
        
        render json:{friendship: friendship, buddy: buddy}
    end

    def end_friendship
        friendship = Friendship.find_by(id: params[:id])
        if friendship
            buddy = Buddy.find_by(id: friendship.buddy_id)
            buddy.delete
            friendship.delete
            render json:{friendship: nil, friend: nil}
        end
    end

    def save_score
        user = User.all.find_by(id: params[:id])
        if params[:score] > user.score
            user.update(score: params[:score])
        end
        render json:{user: user}
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation, :score)
    end
end
