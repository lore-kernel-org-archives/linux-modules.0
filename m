Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:54851 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3LKIuS (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 11 Dec 2013 03:50:18 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <snehal@linux.vnet.ibm.com>;
	Wed, 11 Dec 2013 14:20:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id C12B51258051
	for <linux-modules@vger.kernel.org>; Wed, 11 Dec 2013 14:21:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBB8o3A356492124
	for <linux-modules@vger.kernel.org>; Wed, 11 Dec 2013 14:20:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rBB8o65Y025340
	for <linux-modules@vger.kernel.org>; Wed, 11 Dec 2013 14:20:07 +0530
Message-ID: <52A8273D.6060700@linux.vnet.ibm.com>
Date: Wed, 11 Dec 2013 14:20:05 +0530
From: snehal <snehal@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
CC: Deepak C Shetty <deepakcs@linux.vnet.ibm.com>
Subject: Question regarding kmod pkg
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hello,

I am working on a new architecture - ppc64le (powerpc 64-bit Little
Endian) and I was working on kmod pkg on our ppc64le environment.

The upstream tarball has the config.guess,config.sub, configure and
libtool files

I find that kmod already has updated config.guess, which supports ppc64le.
Following is the latest file, I suppose this is already in tar.
http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD.


We have worked with libtool maintainer to get alpha source release
that has all the needed bits to support building on ppc64le.We request you to spin
off a new version of your package using the alpha libtool release. You
can pick up the libtool alpha source release from either of the below :

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz  (1.6MB)

ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz  (920KB)


Could you please build and install the libtool alpha version and be able
to spin new versions of kmod which would support ppc64le?

Please let me know once you spin of the new pkg

Your response is highly appreciated

Thanks,
Snehal


