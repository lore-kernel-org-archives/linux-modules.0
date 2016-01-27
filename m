Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22716 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965380AbcA0TdA (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 27 Jan 2016 14:33:00 -0500
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u0RJWxsU008596
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Wed, 27 Jan 2016 19:33:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u0RJWwoU015115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-modules@vger.kernel.org>; Wed, 27 Jan 2016 19:32:59 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u0RJWw7i009580
	for <linux-modules@vger.kernel.org>; Wed, 27 Jan 2016 19:32:58 GMT
To: linux-modules@vger.kernel.org
From: Samson Yeung <samson.yeung@oracle.com>
Subject: modinfo crc32 broken after fd44a98ae2eb
Message-ID: <56A91B6A.2060205@oracle.com>
Date: Wed, 27 Jan 2016 11:32:58 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi all,

Please reply directly as I am not on this list.

Commit "fd44a98ae2eb Fix race while loading modules" also broke 'modinfo 
crc32', specifically, for me.

Is this a bug, is it something strange going on with crc32, or is it 
intended behavior?

This happens on the official RedHat EL7 kernels, and also Ubuntu Wily's 
kernel.


Regards,
-Samson

