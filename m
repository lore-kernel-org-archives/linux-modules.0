Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371625;
	b=bS4U2yzrz0Ud1XTobZZeXUiYPfw1R+kkmwgtiumxCB5vz3OZ4gpv6GkePQbmnL+lHjOI
	 gnmbzjcWMeO7F5d3TaHuUYfCxt3Sbm/9/hGY5OOdnCNDAdGOGlHYAoJ3djygl6qWrxp+a
	 ARwOEWMYlLldUxU/AuP43hC9xcdhQbByDFhYaftls1+ZSC+cm91PI5qa9l+h4q9w1Fjab
	 4K+vbrvgIPwKDImZVZEf1iwx7NBIhkYAQTvW2q8jpthuzXUMU1gn0IDmlUjaesmJNdz4W
	 auAF6OQoUI7EHWrPz/iclimNZDxGXge9DSKyxOlC9PZPVsUhTBVA5/MekstsT9o5VXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FNz3jT4CLcKBWPI7M4VnpA4Y1xwsbgEdgjaTG5V52hA=;
	b=B8yXT43Vi7xleAbfD29tCG9uoA3DC4QNZTMDhXNI9Q0JjRCPWRxVPuos62NP59CYwzDK
	 z4QN1SJDoUl2jNdExMyqWjeWIB/hzBh2j9XnPpvS3qVR8kvdrBw8N4zeIAtWEyvQ2Qr6g
	 62YewhjjOV8LcFSLjHFpKp8WVEf1seQuALJFL9GOseHkREKau6znBG18eIks3UrPTdpzL
	 vu4qbNzzFwfnoINqNmjzk1bKs/YQI8RSoaoFS+vq91La4v/YfHL7uGkbNe9zXjCuARMnK
	 IK0XP+Kiw4z1F9RMugMrM3sM5zVNkLwEZG2unsmabz0ovEbV0KX4soGmpr33SwC5O2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+PJz56i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5944606A327;
	Fri, 30 Oct 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+PJz56i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CD1F000C1;
	Fri, 30 Oct 2026 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371625;
	bh=FNz3jT4CLcKBWPI7M4VnpA4Y1xwsbgEdgjaTG5V52hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G+PJz56izIh6pQmZqspvYOmjdWZ3E88eDisXW8Cs2tdMSq2TSME28XvHlx3+EAw+p
	 GP04tc4cYACm9CwH7bhLuHxZHn2ffNxHxSH/FRMwijqqN4MazvOQJHFyxXQpRl6Oah
	 H4zOs9Vkuc6QgIdGJsKM2B2w+/H08y/Q9W8bvEUAeN2JPtospAjkkB5xvg2PgeJuWE
	 5p3IK4uEheA63kg/GT+bZ00q6PPx7f7AgQevlBEG4UJRlaIcc7AAW0u7icGj7Duv0/
	 wZYib7I20AW5GCS5NsFEFaA71sd28YSkwVFsgcldgEquRNnSyC0O/fiS5dC4dxpi9r
	 NkDa6b5wDCLPw==
Date: Fri, 30 Oct 2026 09:47:03 -0500
From: Lucas De Marchi <demarchi@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Emil Velikov <emil.l.velikov@gmail.com>, Tobias Stoeckmann <tobias@stoeckmann.org>, 
	Lucas De Marchi <lucas.de.marchi@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Anton Moryakov <ant.v.moryakov@gmail.com>, 
	Dawid Osuchowski <linux@osuchow.ski>, Rudi Heitbaum <rudi@heitbaum.com>, 
	Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>, Wentao Guan <guanwentao@uniontech.com>, 
	Yannick Le Pennec <yannick.lepennec@live.fr>, Yuntao Wang <yuntao.wang@linux.dev>
Subject: [ANNOUNCE] kmod 34.3
Message-ID: <auSsJsiiuE97DA_M@rpl>
References: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
 <un4amoqszsfdngir4skk3rpztouptrxfxrd5riiwof4ba6gt63@hrzi233bjuyh>
 <nbfzghf5ol2unxajqj2fumagq25leri3dtnlu47rsxyr63g2ul@g5zgumnoxpps>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nbfzghf5ol2unxajqj2fumagq25leri3dtnlu47rsxyr63g2ul@g5zgumnoxpps>

kmod 34.3 is out:

	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.3.tar.xz
	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.3.tar.sign

Misc bag of fixes.

Shortlog is below:

Anton Moryakov (1):
       shared: util.c: fix buffer overflow in alias_normalize()

Dawid Osuchowski (1):
       testsuite: fix dirty rootfs error message

Emil Velikov (5):
       libkmod: return ENOMEM when strbuf_pushchar(s) fails
       man/modprobe.8: use MODULE_DIRECTORY as applicable
       scripts/sanitizer-env.sh: remove incorrect $CC quotes
       man/modprobe.8: document --remove-holders
       man/modprobe.8: document --show-exports

Lucas De Marchi (3):
       tools/modprobe: Fix odd --remove-holders behavior
       ci: Fix alpine setup
       kmod 34.3

Rudi Heitbaum (1):
       util: Use const variable type in mkdir_parents

Syed Labeeq Sajid Bukhari (1):
       libkmod: fix type confusion in kmod_module_get_sections() error path

Wentao Guan (1):
       libkmod: Fix open file which some char device

Yannick Le Pennec (1):
       tools/rmmod: fix garbled error message

Yuntao Wang (1):
       libkmod: Fix dependency count in kmod_module_parse_depline()

thanks
Lucas De Marchi
