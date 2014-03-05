Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx.hs-offenburg.de ([141.79.128.11]:48013 "EHLO
	mx.hs-offenburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaCEIto convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-modules@vger.kernel.org:1:1>);
	Wed, 5 Mar 2014 03:49:44 -0500
Received: from gwia2.rz.hs-offenburg.de (gwia2.rz.hs-offenburg.de [141.79.10.30])
	by mx.hs-offenburg.de (8.13.6/8.13.6/SuSE Linux 0.8) with ESMTP id s258nnP3011605
	for <linux-modules@vger.kernel.org>; Wed, 5 Mar 2014 09:49:49 +0100
Message-Id: <5316F334020000460004B5AA@gwia2.rz.hs-offenburg.de>
Date: Wed, 05 Mar 2014 09:49:40 +0100
From: "Frank Ihle" <frank.ihle@hs-offenburg.de>
To: <linux-modules@vger.kernel.org>
Subject: Linux kernel module is not running anymore when switching from
 mdev to udev
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi everyone,

there is this problem, that I searched the Internet 
for its solution but without success. Here's what it's about, I hope 
someone can give me a hint:



        I'm using Buildroot 2013.10 to generate my Linux 2.6.39 Images, with the following Kernel  module:



  void GPIO_LED(void) {

  printk(" GPIO: set PC8: '0');

  at91_set_gpio_value(AT91_PIN_PC8, 1); 

  
  }

  
  int init_module(void) {

  GPIO_LED();   return 0; 

  
  }

  
  MODULE_LICENSE("GPL");



When using it with mdev device management. everything works just 
fine. But using it with a udev device management, while executing insmod



  insmod /usr/modules/measurement_gpio.ko



the following message appeared:



  insmod: can't insert '/usr/modules/measurement_gpio.ko': invalid
  module format



Every setting stayed the same (especially the kernel version) but the
 device management changes during this test, so actually the module 
should be fine. Building the kernel to be able for loading modules for 
multiple versions didn't solve it, neither the option "force module 
loading"


The way I build my module is:


with Buildroot I'm generating an Image, on the way a Linux 2.6.39 is installed.Afterwards I'm compiling the kernel module with the path to the Linux 2.6.39, that Buildroot has downloaded.When the module is created I'm putting it into a fs-overlay directory, so it will be included into the image on next build.I hit another "make" on Buildroot and i got everything together and a bootable image.


I change nothing, that's why it confuses me even more


How can this be and how to solve it?

Kind Regards,
Frank
