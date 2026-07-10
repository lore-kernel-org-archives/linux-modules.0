Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068713EFFDB;
	Fri, 10 Jul 2026 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672118; cv=none; b=N1gflzBnrskpzCKzF5+I45KfuTb1h2w4SkXG+fvUk4AtTIvSQnCsjZMx7SqJlhsc3QJdofhnGtDz4FoouujNQQeqC0FygkqBxxwaCgxc8tZM1WocV1FCm3tx/UcD+d8dYSuksuRTPT9ImHMdZQYHT8Hqh/uMEQfaod3pGAWhkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672118; c=relaxed/simple;
	bh=T1DHLoatQkT8dNSQHiuZnZAYK8fNam3WvgE/unEoi/A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oqOKFgJtvjDFBtOylK+9B3Ti8ofNvdxl48EE9yqn1gcpsgpd4ix+i1AEfRFgSFaJg4zBWneNgDwK80e6gEtDgOxXOucrwhUSC8qfrNYYsxTkPSP1owQzKYnO/ekulMfdSOSjoKqmm84R2uToWUfOywi6TNA51RVFQi9hC9BUfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mACi2Gb8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mACi2Gb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783672114; x=1784276914; i=markus.elfring@web.de;
	bh=T1DHLoatQkT8dNSQHiuZnZAYK8fNam3WvgE/unEoi/A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mACi2Gb8fwDACF1UFcYUNwHwXXThMYQRDlHo1xGa8q+0l2xs1ZvAxMUPX074R2oh
	 cJQCo+0DPlnYGUD0SoTvfjla9FHs6/rk1IMTxeZ9fuEdvWWYMMfH8gpI+V1gQ9ORT
	 x+hwJVFxCqf/D60oqZycCk/stvRQwhxNK5pWRW8jx7L2K8fqdNgx0JUBEDfV+7sfd
	 fGkV4If0SuvnAbM2+VRhF+jgnAkAQuCSKf3qMsrkFqAnBXEKYXU7zvyWWoa7XsCG1
	 AJwowOfbS5OH5/2yI1SaM8vrsBV6e1sgrPZpHWmS1SPJ4+1gueoWiA2dIGsVMkk90
	 1FLTMXfQekMJodnTKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1wnagU3IGa-004j0a; Fri, 10
 Jul 2026 10:23:02 +0200
Message-ID: <99301e32-b067-4d0a-a087-2c77b1fe0a90@web.de>
Date: Fri, 10 Jul 2026 10:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Siddharth Nayyar <sidnayyar@google.com>
References: <20260708012107.1621513-1-tweek@google.com>
Subject: Re: [PATCH] module: validate string table section types
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260708012107.1621513-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gaMLAr9dGS2qQ2CJfzAozJgiyS9vgwKWoEneAYa5HzKOOSguY1a
 XTt647R6JqYU60DHyKo0TZBbPatRm2xV/DJ4MOQ40HTOsDGX+rXj23EaAhYAkz/A+81RQp3
 7QPzpvchzHfSoLpJVghYEzxij8Q0PPHsE//y6fuJ87BtaNwHTLBtSWnai0ahf8Iu756jVo/
 IA3gPPV2CISojJbPjt4EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQKFcgjjYxs=;ofCvbwIQ224XMGviCCqlmCHU7Kw
 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
 4u6jI8aXpFziyfKZKiCBWghaTc0=

=E2=80=A6
> Validate that both string section headers are of type SHT_STRTAB before
> caching them.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

Regards,
Markus
