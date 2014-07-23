Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:59461 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbaGWN1s (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 23 Jul 2014 09:27:48 -0400
Received: by mail-yk0-f174.google.com with SMTP id q9so749069ykb.5
        for <linux-modules@vger.kernel.org>; Wed, 23 Jul 2014 06:27:48 -0700 (PDT)
Received: from [155.1.1.163] ([187.11.221.17])
        by mx.google.com with ESMTPSA id d58sm7355049yhf.2.2014.07.23.06.27.47
        for <linux-modules@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 06:27:47 -0700 (PDT)
Message-ID: <53CFB829.7060006@gmail.com>
Date: Wed, 23 Jul 2014 10:27:05 -0300
From: Daniel Hilst Selli <danielhilst@gmail.com>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
Subject: Re: [PATCH] depmod: New option for m-i-t prior 3.6 compatibility
References: <53CFB7FC.5020906@gmail.com>
In-Reply-To: <53CFB7FC.5020906@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


On 07/22/2014 06:27 PM, Lucas De Marchi wrote:
> On Mon, Jul 21, 2014 at 4:33 PM, Daniel Hilst SellI
> <danielhilst@gmail.com> wrote:
>> New option (-N, --no-relative) create databases with absolute paths.
>> This option is made to create databases compatible with
>> module-init-tools prior 3.6 version.
>
> What's the use case here? Do you want a newer depmod to create a
> database to be read by ancient modprobe (from 2008 as far as I could
> check)? Why?
>
> If it was the opposite (make modprobe to work with old database), I
> could understand. But I can't really see why you are doing this here
> and it just sounds crazy to me.
>
>
> Lucas De Marchi
>
I work with embedded systems from 2009, which use modprobe from m-i-t
3.4, updating m-i-t means update tons of nodes. Of course I can simply
run depmod from target and get everything fixed, but this creates a
dependence of running stuff after installing the image, which is
unproductive. I want images working out-of-box after generated.

So I patched depmod to generate databases compatible with my old
systems, without harming new features.

Cheers,


