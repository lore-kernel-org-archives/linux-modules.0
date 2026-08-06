Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34C37C92A;
	Thu,  6 Aug 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010351; cv=none; b=Kvvn3coKjRv6i3fafna8z6WzWi8DYrtT2JE/1FUcUNvrQfdIORcG1vtwS2dCTe/FVSm46gtnTrqDdlggSLtJcmm5+B+4kG11mCDkOFMILRvHKj39z24VygBOOR/1OIsOzkBxXKYmtzEc7Jx5FCuWh7qUlVKISiu5RdfHGaQFRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010351; c=relaxed/simple;
	bh=97/nlFpqHy/LEugzRHwOFZ1cN+nhkqEFc/3ZBLZIAdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVnmSRJ00OxM/47vCdJDshMIl6EK5Aib9AZc3es8sIKRQuhNNS0yk3yXlNrigdHrW/5uklL65ip7qgKh74WdU8J/1j5FdHcaogQsQlMlULF4bdfcJZkxeOTJFtgkh31tdLtr+qWp4hPwxPh1YQe+C8JVceDhmYfzPMn9YKM7KGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Hb2USHrY; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Hb2USHrY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZVBzTOpJvQdc3kvEZNdrQSwpBB+rsEs/rfNxos6CNk4=;
	b=Hb2USHrYKLxu9v7vqQ111lRpMDKhmY0OX4xfFppo+knkferqSllL2Bz6jRO6u2PN1ypgVauy7
	pwegRKCzQ6IemGTWa0Ul0Ahvu9KpKOhMK6zQc+wnjnF6tvVmxA3SJm+H20h8HU7CaSBTonKXTlI
	UgFU4xjlXfk1dUJMlvB6uyA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hG2YW4h2vz1prNF;
	Thu,  6 Aug 2026 17:49:19 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EAF44056E;
	Thu,  6 Aug 2026 17:58:53 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 6 Aug 2026 17:58:52 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <petr.pavlu@suse.com>
CC: <atomlin@atomlin.com>, <da.gomez@kernel.org>, <egg12138@foxmail.com>,
	<jpoimboe@kernel.org>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<linusw@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<linux@armlinux.org.uk>, <mcgrof@kernel.org>, <rostedt@goodmis.org>,
	<samitolvanen@google.com>, <xiaojunzhe1@h-partners.com>,
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH] ARM: unwind: modules: Fix the mismatch between .ARM.exidx* and .text
Date: Thu, 6 Aug 2026 17:58:07 +0800
Message-ID: <20260806095807.24475-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <449549e3-8670-4c9e-a348-0ad3c6a521b2@suse.com>
References: <449549e3-8670-4c9e-a348-0ad3c6a521b2@suse.com>
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

On Thu, 6 Aug 2026 11:40:23 +0200, Petr Pavlu wrote:
> A fix for this issue was posted previously:
> 
> https://lore.kernel.org/linux-modules/tencent_08845B64E5F38EB7FA1779982A071AB4A607@qq.com/

Oh, sorry, I didn't know about this. Let's discuss it on
previously posted patch. :)
