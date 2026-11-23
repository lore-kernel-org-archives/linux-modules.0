Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447511;
	b=Y+rqG6aHwMawVj9c4gFN502qbeZYb1UhHwcI3ktiluU9Xbja30q4PMkRqkNPpZn4PCym
	 IIbsn8PXh1o4XvN09gvOAotvSDWXVKvFMTJUlBufuG+RPa6ssfe1ODvMBwkYVb8tJ8zMW
	 KhfSWzeOCEHxpHTMf894n+G/HJp5oGpCODGlfvDWwUyGGOaX2Zb+svqyISJ2eYXDHTSIm
	 gUQCEmWpCqTM8p21cHEfFj37LFlTsr8lF6MJMIfCCB3qr6x8u9hDIHiZwVx0ONX2Eaoip
	 9A69OpDiWTTLxovLzw2Gtp1JQUu6gNYJDcdSbooRXck4wq+L/Cls5/9Es7SQBgxEwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447511;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Y84rEGg7gX2FsTtW7vT7MXk+0wc/fk9om2kO34pvYZM=;
	b=vDURkY7N0ycJwI1lajX1n8uQ4fShF1MOLrnQ+7BwlBw6VwwmhEbmMCHww6ULEfQICmji
	 bxU8slLNNZGvm+oX1nbUgtjAJfPd9uAgAl9gEgoiHZH0Xtog7SogLUC11jwYkZTN3sx+R
	 YfbIPTjYLBi2OgL/lx79AycCsKObRgpDUy0SvldtDxuYG7X1qUdDcYDBz2vwnUhzTkqTt
	 /ROipM7o+BH1Ro5SU710E8F7FpESo5Tc1ylrIIjNqhvpMPmjvVk+DkSZ6OdYUoeQFWTu7
	 /dG0L8IvrNFk5vzwsTO12WKTu0+39tdQxZQAuBLZ+PvnXpMaPGovrPnjrxSBvEycqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JekLIvUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7F606A31F;
	Mon, 23 Nov 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JekLIvUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027ED1F000C6;
	Mon, 23 Nov 2026 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795447511;
	bh=Y84rEGg7gX2FsTtW7vT7MXk+0wc/fk9om2kO34pvYZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JekLIvUXJY3hcoGBZLqsWR/Ql2LdjGw8XNoDAp1EOzUlDRdBrst8j6K5TLlPsEWoG
	 9o8K4eF3gA3ixByJeDuh3OzM4UZSeIeTNDe+5mmEPQp8qwxc3sWQvpWVAMirjlgLef
	 AvvxnYxPrpo6BQnTNWOYa2PNej+Uo6lFmST8+XN3S76r9DTjeS3VleH/CBOQQXp4ly
	 UVzl8NX70ZIhgdKuhaA8J/ZVg91lWYwWRslJckuyxBHWbIzrU+dJXkXyXiqs83Bqlp
	 xGHGQF81UoVYG8s/kDwGSP2Zq1a6YWScG3Hpb7buZwypl8YEcY1BWaOKmQm2H0dMpF
	 f2kHHX9QbouAA==
Date: Mon, 23 Nov 2026 09:25:09 -0600
From: Lucas De Marchi <demarchi@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Emil Velikov <emil.l.velikov@gmail.com>, Tobias Stoeckmann <tobias@stoeckmann.org>, 
	Lucas De Marchi <lucas.de.marchi@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Anton Moryakov <ant.v.moryakov@gmail.com>, 
	Dawid Osuchowski <linux@osuchow.ski>, Rudi Heitbaum <rudi@heitbaum.com>, 
	Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>, Wentao Guan <guanwentao@uniontech.com>, 
	Yannick Le Pennec <yannick.lepennec@live.fr>, Yuntao Wang <yuntao.wang@linux.dev>, 
	Andreas Schwab <schwab@suse.de>, Jakub =?utf-8?B?xZpsZXBlY2tp?= <jakub.slepecki@intel.com>, 
	Kron Kastrati <kronkastrati900@gmail.com>, jared mauch <jared@puck.nether.net>
Subject: [ANNOUNCE] kmod 34.4
Message-ID: <awRZShT204Vh-HY3@rpl>
References: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
 <un4amoqszsfdngir4skk3rpztouptrxfxrd5riiwof4ba6gt63@hrzi233bjuyh>
 <nbfzghf5ol2unxajqj2fumagq25leri3dtnlu47rsxyr63g2ul@g5zgumnoxpps>
 <auSsJsiiuE97DA_M@rpl>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auSsJsiiuE97DA_M@rpl>

kmod 34.4 is out:

	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.4.tar.xz
	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.4.tar.sign

Misc bag of fixes with some compat handling for newer libraries/kernel.

Shortlog is below:

Lucas De Marchi <demarchi@kernel.org> (5):
       libkmod: Fix UB for non-existent keys
       libkmod: Fix missing module normalization from kernel cmdline
       testsuite: Fix build warning on kernel 6.15
       ci: Paperover Archlinux openssl 4.1 deprecated symbols
       kmod 34.4

Emil Velikov <emil.l.velikov@gmail.com> (3):
       depmod: remove dead error checking code
       tools: remove unused kmod_cmd_{insert,remove} declarations
       modinfo: remove hard-coded "foobar not found" messages

Andreas Schwab <schwab@suse.de> (1):
       testsuite/init_module: Handle __NR_riscv_hwprobe in syscall wrapper

Jakub Ślepecki <jakub.slepecki@intel.com> (1):
       libkmod: unref list before returning with error

Kron Kastrati <kronkastrati900@gmail.com> (1):
       libkmod: fix build with OpenSSL 4.0

Prabhakar Pujeri <prabhakar.pujeri@dell.com> (1):
       libkmod: Propagate errors when joining module options

Tobias Stoeckmann <tobias@stoeckmann.org> (1):
       check strtol/strtoul/strtoull results

jared mauch <jared@puck.nether.net> (1):
       tools/depmod: Fix memory leak in depmod_module_add error path

thanks,
Lucas De Marchi
