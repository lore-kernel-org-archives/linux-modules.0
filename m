Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E11C5F10;
	Sat,  6 Sep 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175101; cv=none; b=QNwjXfOgFbsn9KNs2Aag69o5/U8iiO5ZfCetuwBcmLorWavBGLqrP1NgFTHMWy7LdscKCPq5jOOkHzSooySrjMQ1cIGoRuP1DHVypqedD6WTqJ+B4F+e9pul4pD2z+YlSPjni92kAr1Aif+v7iW4/hKCRyaHDLujn7i+cmOfuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175101; c=relaxed/simple;
	bh=22bHRaaV56nZf1mcieymHK5Cq5dUnmUr/0oZXOl1TU8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=reNXzPfOvkeE+iHJGRrzm8eGIG0GsRTN5px9F53GBKBcwy3rntW42X1SX3w8efyUvRJD7ovdhsw0JBw7xf3pG4DnonMuj/Mmkq6a7ggW0kn6OesQJjkVfC0Y6agrwfMKLpefaPAAiSUakiNB+I5uPd6EfhM2lwe2Jk2ACzAYEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IH3xpAQR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IH3xpAQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757175089; x=1757779889; i=markus.elfring@web.de;
	bh=22bHRaaV56nZf1mcieymHK5Cq5dUnmUr/0oZXOl1TU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IH3xpAQRP7qpFrH7muIFSf8j/WGygg/qSVGO1D52Iv0y55bLc/IEgh+Fue/1TJlK
	 UJUCumrSNZg+fZh2LNYv1h+p2KJ5HduQ9qfluJN6CY0lnozfDSTsZQx/Z/lqgd5Yw
	 rjiJ6LdMjo1gyRdBuXvbFriYt+5m2glnMfzFV6+F1SM3BMShWdeCeDBZyemlnnEus
	 zkL7Y9floqzw6x3t+IeSBsu/4L3mZwF/9ob+gTqzkSZpNs8tyIYRJtS98Rb8n1YJL
	 BFgEO0lM5w76B3Dmc1aVTqxFFzYzvONlQMNg3POCJbSHNEFiCkrQg55FNQT5fsgpi
	 4e9T5RirrTHjmyHITQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1v2rTQ2iaD-00RFpm; Sat, 06
 Sep 2025 18:11:29 +0200
Message-ID: <15e9fc92-5950-4e39-aac1-95487752eedb@web.de>
Date: Sat, 6 Sep 2025 18:11:28 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fidal palamparambil <rootuserhere@gmail.com>,
 linux-modules@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>
References: <20250906122731.946-1-rootuserhere@gmail.com>
Subject: Re: [PATCH] arm64/acpi: Fix multiple issues in ACPI boot support code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250906122731.946-1-rootuserhere@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:46hHjNM1VDZVIdQg6x6d42MV6yrJqUGXCLBc0Jmyq6Hk2kko3JB
 +ZbdY3o2Thaj6OiPzpjQSx78GAKJS2Geoyn+//5BhKbi5rDNm1Fb1BVePUEppqQIuxTGHt8
 UXSxwQ3levTWohEqszXwRhhGvHld7/6UpsTXlfNVOmxPpSIYbfjlx6bN6q2ZiRCQRictxUa
 pkWx1DOOua787H2BzeRRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xJD/Ldmy/Yc=;DimlsiOvAaYY/BkVhgg0081i0Ce
 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
 FIM4EmQwAS

=E2=80=A6
> These fixes address potential memory leaks, compilation warnings, and
> improper error handling in the ARM64 ACPI boot support code.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n81

Regards,
Markus
