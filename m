Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4C4908A9;
	Mon, 27 Jul 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138498; cv=none; b=e7p8OplOr+fwcyiUVgdQaqRzgEwlMhnZiGdaESfzQlNIp2jTI932lJ39WP88s9meI7Z3dPfg7WO4gEcc8G41Yg6STMfiV/CBL9ZcZPsocJ2M45lOK8uDRePTPB6JXH+RfWegC84rVgNgKaHTzFUV1iphA/ipx03T6QDU8b9j3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138498; c=relaxed/simple;
	bh=je38862WqI6csR6Tw7QL4GiqzebSyLQAdq1BP0Do8oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ri80I6LM0waXb4ssIO75EYPNuaGqZxXD9pgOoXnkVYeJPrT8S4eWU2+luJ1EsUbuEK7wh76TwC3EixFSTaVa3tEfbZ8ZE36MT6vXplWzfMY607I60UsDVkB/SlGTY8M0nlWwBdsFGG4I5E7xsZuyOY/118L/53RyA/kjvwyinQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CBkWPhc1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CBkWPhc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZS
	tcuhfdE7XxAahWW2ecan0c6zEbfCVD7CPTonvHjSo=; b=CBkWPhc1I89BZjYVgz
	2ISa/fi0husOK1ZC2jKDPaF2RFEHOebY9qtFwtzHf7y/lM2AmLMIbkwnEJFcqIA6
	318vwueZQwqLNa2xArFLKj/qz/EMjp/1zteiJgY7VP37trSOeZBwc7uxWLSnn6ZD
	/ajRq0ym5l46ubQLp7lN4FmrU=
Received: from fedora (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3UdQJDWdq26SaJw--.39752S2;
	Mon, 27 Jul 2026 15:47:21 +0800 (CST)
From: Ju Nan <junan76@163.com>
To: egg12138@foxmail.com
Cc: jpoimboe@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux@armlinux.org.uk,
	pmladek@suse.com,
	Ju Nan <junan76@163.com>
Subject: Re: [PATCH v3] ARM: module.lds: fix unwind metadata for merged .text sections
Date: Mon, 27 Jul 2026 15:47:09 +0800
Message-ID: <20260727074708.115112-2-junan76@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
References: <tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3UdQJDWdq26SaJw--.39752S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF48uFyrZFyDGFWDArW7CFg_yoWDurgEg3
	Wvq34Utw17W34Duws8Ar4YyFyDWr4UWF17Jay8AFZIyr40qrsIvw1rAr90vF17Xa1xurZ3
	ua43XrZ8uwn7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUxR65UUUUU==
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC0wm5a2pnDQkD8wAA3x

I ran into exactly the same on a STM32MP157A-DK1 board (dual Cortex-A7,
ARMv7 AEABI, CONFIG_ARM_UNWIND=y).  An out-of-tree module whose functions
GCC had placed in .text.unlikely (merged into .text by module.lds.S) left
its .ARM.exidx.text.unlikely section unregistered, so an Oops inside the
module produced an empty backtrace:

  Call trace:
  unwind: Index not found bf102018

With this patch applied, the module's exidx is coalesced into a single
.ARM.exidx output section, module_finalize() registers it against .text,
and the full module backtrace is restored:

  Call trace:
   do_the_crash [oops_null] from level_one+0x8/0xc [oops_null]
   level_one [oops_null] from level_two+0x8/0xc [oops_null]
   level_two [oops_null] from trigger_write+0x18/0x20 [oops_null]
   trigger_write [oops_null] from full_proxy_write+0x54/0x78
   full_proxy_write from vfs_write+0xd0/0x49c
   vfs_write from ksys_write+0x6c/0xf4
   ksys_write from ret_fast_syscall+0x0/0x54

Tested on Linux 7.1.4

Tested-by: Ju Nan <junan76@163.com>

