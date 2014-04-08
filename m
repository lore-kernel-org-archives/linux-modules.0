Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:54616 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbaDHEoK (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 8 Apr 2014 00:44:10 -0400
Received: by mail-yh0-f41.google.com with SMTP id v1so389120yhn.28
        for <linux-modules@vger.kernel.org>; Mon, 07 Apr 2014 21:44:09 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Apr 2014 10:14:09 +0530
Message-ID: <CAGZFCEGVxMzsihhWRZPZPDRrxUhJxULj79wu0uQ5CXHgkThA+A@mail.gmail.com>
Subject: rmmod resource busy
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
To: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

When i tried to unload a module, i get following message

" Error: could not remove module tun_module: Resource temporarily unavailable "

1. How to find  which process is using it ?


Thanks,
Ratheesh
