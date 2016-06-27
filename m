Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from static.148.38.9.176.clients.your-server.de ([176.9.38.148]:34972
	"EHLO manjaro.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbcF0XW6 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 27 Jun 2016 19:22:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by manjaro.org (Postfix) with ESMTP id 678683125815
	for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2016 01:05:09 +0200 (CEST)
Received: from manjaro.org ([127.0.0.1])
	by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0Juf0vBo3ik for <linux-modules@vger.kernel.org>;
	Tue, 28 Jun 2016 01:05:07 +0200 (CEST)
To: linux-modules@vger.kernel.org
From: Bernhard Landauer <oberon@manjaro.org>
Subject: error: EXTRA_DIST must be set with '=' before using '+='
Message-ID: <f3e2ee06-8fc2-aa6c-d72f-324277004c06@manjaro.org>
Date: Tue, 28 Jun 2016 01:05:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi!

Latest git commit fails building for me on Manjaro (Archlinux) with:

Makefile.am: installing 'build-aux/depcomp'
Makefile.am:207: installing 'build-aux/py-compile'
parallel-tests: installing 'build-aux/test-driver'
libkmod/docs/gtk-doc.make:33: error: EXTRA_DIST must be set with '=' 
before using '+='
libkmod/docs/Makefile.am:29:   'libkmod/docs/gtk-doc.make' included from 
here
autoreconf: automake failed with exit status: 1

Do you have any hint for me what might be wrong at my end maybe?
Thank you
regards
Bernhard Landauer

