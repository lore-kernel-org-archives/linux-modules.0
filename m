Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F525F99F;
	Fri,  7 Aug 2026 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068866; cv=none; b=fmkJQSQpZJjS9+sSdtLGDOdoPTsuWuVZO26CZiB/o0eba0jHkXyFsz+Xfrd+qItZDNEvSPgAltwrodEP0bwWq/b4K75RQ0ggRXfPv/lxF13jd0AbyJ1uSQYzBxElbygNu8vMDGZ04ejLfWalm9A7VDZteZk7KNWwvmwT3PQrBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068866; c=relaxed/simple;
	bh=wFQy0Ajmq7rXQX3+ulTVvrqXuVPElSo12sQFDaX/GfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIcQb4K5gSPj+3fwRU1XLSRDO7L/otJ0+bKeU/tWOT8HK+QVv22wSs91aBdmV03aSAvEvgI66ZRLHT3MiCX21EOIol+jPpjnVJ1UkHgP7nZpdNMvES/0JcYpxIeuGPJ9uqG4+vYRjl2VQ3/wIbbgWM60ZiPLBKWJpuNKJaGbde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Cds762bF; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Cds762bF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zdSEhSWgKAuiPO1HyQjMS5msQKsGOwK8wbTor0f0Eqc=;
	b=Cds762bFaP1jrL2D+AT8Hf5c+SAHwDOsnPQRTLq87x7755dQ/l9oTbNZXBUIMU8YsnHC2xGWf
	0apeXmOMABONjdgO3LHqpcYtVuJBbpxKzr/QpYNJRXeBMu4+o28858SxqD7uSg/yRTBRGpfSI6J
	JnlrLyRiwlW7Oh3m5GVM/d0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hGS9v2ddxz12LGW;
	Fri,  7 Aug 2026 10:03:47 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 803144057A;
	Fri,  7 Aug 2026 10:14:15 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 7 Aug 2026 10:14:14 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <egg12138@foxmail.com>
CC: <xieyuanbin1@huawei.com>, <jpoimboe@kernel.org>, <linusw@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-modules@vger.kernel.org>, <linux@armlinux.org.uk>,
	<petr.pavlu@suse.com>, <pmladek@suse.com>, <rostedt@goodmis.org>
Subject: Re: [PATCH v3] ARM: module.lds: fix unwind metadata for merged .text sections
Date: Fri, 7 Aug 2026 10:13:28 +0800
Message-ID: <20260807021328.36897-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_EB65B78E967A5FF9DD2A591A86A6BD5B1107@qq.com>
References: <tencent_EB65B78E967A5FF9DD2A591A86A6BD5B1107@qq.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Thu, 6 Aug 2026 22:29:03 +0800, Xiao Junzhe wrote:
> My reason for including the exact matches is slightly different.
> AAELF32 defines these section namespaces as .ARM.exidx* and
> .ARM.extab*; it does not require all ABI-conforming object producers to
> use the same naming convention as GNU as and LLVM.
>
> For example, another producer or future version of GNU/LLVM impl for `as`
> could validly use:
>
>     .text -> .ARM.exidx.text

I have thought about it again. For other sections, the mapping is
as follows:
	.xxx -> .ARM.exidx.xxx

So, if there is an ".ARM.exidx.text", it must be from ".text", and adding
".ARM.exidx.text" will not cause any other harm. We only need
to ensure that the merging of the ".text*" sections is consistent
with the merging of the ".ARM.exidx*" sections, and the current patch
already satisfies this requirement.

I have no other questions about this, so:
Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>

Also, don't forget to submit your patch to Russell's
patch tracker:
Link: https://www.armlinux.org.uk/developer/patches/

Thanks.
