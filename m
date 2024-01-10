Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E631BE5E
	for <linux-modules@vger.kernel.org>; Wed, 10 Jan 2024 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NDkT06UG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iu3Be0mgE1pG/GYdicEmaBDJ8GA7/03pFVLQQM4LTJY=; b=NDkT06UG380JztLhQlfkcFA801
	3TZd+qKwZdYEE4/KJ8lLFwJfT4z8DspPj1AJNwXqhZEseLElFUa4C2ht6dh5mPpQEqTjA4fn4jqMY
	3wJNvwncb/fd+vN1zmlvUnLNDH1U3YkXlghJNdb8G2N4yGLhnJdpfBS8CWcq9Q9J7zgprDOPyDjvG
	dYXJRfdnecKXQY6HyEopsEsOhcHLvQR/7x2F6dckCXOYLg4boElE1YyluTvF46lC7ZKaEguhEQRvI
	VhDFnSMCGhi/1Zf3SRIAqI+NY2ZHmTtLV9/hK+GDQHd0cZE8YsfO6osHF7zABlJk18NCbrXDY+ER0
	BDWAtf9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNVQM-00056s-28;
	Wed, 10 Jan 2024 10:03:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNVQK-0005CV-NS; Wed, 10 Jan 2024 10:03:00 +0000
Date: Wed, 10 Jan 2024 10:03:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: artem.kuzin@huawei.com
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com, mcgrof@kernel.org,
	nikita.panov@huawei-partners.com, alexander.grubnikov@huawei.com,
	stepanov.anatoly@huawei.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com, kang.sun@huawei.com,
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH RFC 00/12] x86 NUMA-aware kernel replication
Message-ID: <ZZ5rVJo1Dn9e12vs@shell.armlinux.org.uk>
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228131056.602411-1-artem.kuzin@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 28, 2023 at 09:10:44PM +0800, artem.kuzin@huawei.com wrote:
> There was a work previously published for ARM64 platform
> by Russell King (arm64 kernel text replication).
> We hope that it will be possible to push this technology forward together.

Honestly, I don't think the arm64 kernel text replication is going to
progress. I had zero feedback on the last posting, which suggests that
there is very little interest in it.

With Ard's suggestion to use pKVM for it, that's totally and utterly
outside of my knowledge realm about how to implement that, and I have
no idea what the implications of doing so would be - would it prevent
being able to run KVM guests? How does it interact with the KVM
hypervisor? Does it require nested virtualisation (which isn't
supported on the platforms that Oracle are interested in.) Then there
is now the pKVM hypervisor for kernel text replication would grab the
memory it needs to replicate the kernel.

Having been through all the different layers of firmware, boot loader
etc the conclusion was that it's something that the kernel should be
doing - and the code that Ard pointed me towards was firmware-based.

So, right now I think arm64 kernel text replication is rather dead in
the water.

Honestly, I now utterly regret bringing up this idea inside Oracle.
It has become something of a millstone around my neck.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
