Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC932E143;
	Thu,  6 Aug 2026 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989497; cv=none; b=N5T2B1/srbB6pPCW8q9F8toH3X3Lj1K3zdviZqD1r3S/7MZ61PFjNXYx3XclrUpcz/8tjhJMHKbuiYHOWaKDA1FBBG2Twc2Rob3cN/RExEMh6Hbfn4VTJu5Hxuw5beiy+idkYB5wNLFYpKJabIWwvhS0jbwcgBRYqWNBYbqdmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989497; c=relaxed/simple;
	bh=9atHqxOVxD6ixEO0/HJsudZNx84YOGCzHnB9jlyGZKw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fV1NvzIVK3F8rJ78ozlwVbWFhM0j7mPm1hJs8lyfb5Xdf+Ks+Py7OIKEz9obqQ1J3beCUutCnBGaEDLrAxCXQTNQ4yrfMNL4TH2hIBRrkDCrQQlOF1VS74twRuobhcEiTsftSFxYpJao6Y/lJ4o7U/3wyomZhzXy4qC8O9HsQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ahp1FeN2; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ahp1FeN2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GhpvHly5CfF3XPnV83ib9qN3edGzDbhFkA+3ePHZcq0=;
	b=Ahp1FeN2OicjSMax6uEBEa4o+Z+LD7RaMoFj9qMcP+N8Pw8rB0v4EPidPYUye1UFEEYODu63e
	2JT+7uy95lo1GxRs1PsLMBoI/fttUdEbIkEw7VASS9mtAMxWTTc3+Oc1BxbqvoxzwtbcGYInyfB
	wKsnacJEEWJzQzbSq+MwjWI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hFtrj0krFzmV8f;
	Thu,  6 Aug 2026 12:01:57 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 200A840565;
	Thu,  6 Aug 2026 12:11:29 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 6 Aug 2026 12:11:28 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <linusw@kernel.org>, <jpoimboe@kernel.org>,
	<rostedt@goodmis.org>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
	<da.gomez@kernel.org>, <samitolvanen@google.com>, <atomlin@atomlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-modules@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>, Xiao Junzhe
	<xiaojunzhe1@h-partners.com>
Subject: [PATCH] ARM: unwind: modules: Fix the mismatch between .ARM.exidx* and .text
Date: Thu, 6 Aug 2026 12:10:01 +0800
Message-ID: <20260806041001.143888-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For the new version of the compilers, C code that does not explicitly
declare the section attribute may be split into sections other than
".text", such as ".text.unlikely" and ".text.hot". If unwind is enabled,
this will also split the ".ARM.exidx.text.*" sections.

As scripts/module.lds.S, ".text.[0-9a-zA-Z_]*" sections will be merged
into ".text" section. However, ".ARM.exidx.text.*" sections will not be
merged.

For the following module code, using the gcc-16 compiler and the
latest linux-next code, will result in dump_stack() failure.
```c
void noinline stack_func_issue(void)
{
	dump_stack();
	pr_emerg("dump stack finish!\n");
}
EXPORT_SYMBOL(stack_func_issue);

static int __init mmodule_init(void)
{
	stack_func_issue();
	return 0;
}

module_init(mmodule_init);
```
```log
root@(none):/# busybox/usr/bin/busybox insmod test2.ko
[   10.846774] test: loading out-of-tree module taints kernel.
[   10.851840] CPU: 0 UID: 0 PID: 93 Comm: busybox Tainted: G        W  O        7.2.0-rc6-next-20260805-00002-g3d7269e6e98c #3 VOLUNTARY
[   10.852350] Tainted: [W]=WARN, [O]=OOT_MODULE
[   10.852405] Hardware name: Generic DT based system
[   10.852516] Call trace:
[   10.852939]  unwind_backtrace from show_stack+0x10/0x14
[   10.853487]  show_stack from dump_stack_lvl+0x54/0x68
[   10.853512]  dump_stack_lvl from stack_func_issue+0x8/0xc0 [test]
[   10.854134] unwind: Index not found bf000008
[   10.858157] dump stack finish!
```

Merge ".ARM.extab.text.[0-9a-z-A-Z_]*" sections into ".ARM.extab" section
and merge ".ARM.exidx.text.[0-9a-z-A-Z_]*" sections into ".ARM.exidx"
section to fix the issue.

Signed-off-by: Xiao Junzhe <xiaojunzhe1@h-partners.com>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 scripts/module.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d0f200428957..0ccf0c205d00 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -39,6 +39,10 @@ SECTIONS {
 	.text			0 : {
 		*(.text .text.[0-9a-zA-Z_]*)
 	}
+#if defined(CONFIG_ARM) && defined(CONFIG_ARM_UNWIND)
+	.ARM.extab : {*(.ARM.extab .ARM.extab.text.[0-9a-z-A-Z_]*) }
+	.ARM.exidx : {*(.ARM.exidx .ARM.exidx.text.[0-9a-z-A-Z_]*) }
+#endif
 #endif
 
 	.bss			0 : {
-- 
2.55.0

