//
//  main.m
//  TestArrayBinding
//
//  Created by Steve Ross on 1/11/10.
//  Copyright Calico Web Development 2010. All rights reserved.
//

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
