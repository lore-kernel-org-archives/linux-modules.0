Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9951F2391;
	Tue,  7 Jan 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264651; cv=none; b=MlJDXEy/MgUDrQy+RquQjdCSGwDfnVLE9ledNAfEtr8XCc4U5pmdAdfm/MQaFgS9hUEqK3YQ7lEYpObQHrcB/PH114DcaMMPObJjX26j4og3tD2Jm1Qx1eqzhjHS1pN0nPGn+PDKciOcpCNRNOqcvhhw0/MNE4QUplyZ6jFc5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264651; c=relaxed/simple;
	bh=9FRRC2Sx1ANlYfEV2Wva1xaqYX27Qfnh9caqO/slSS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfQv2TOKmrl2V8P9/rv5Gwkgjt+2I55LarKx7PXhJjzTEaG7DmKAId2UezmFNsxL0uvrKr2s2mMKMk5bMSC1SptCkaS2++3A3sTLk7OSnOJZZKYnf4N9h5vsZhhEQ227SwGicMWeep6uFMI0PYDf1kAAMZqBLU/3SO4qHxbE8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/qNQf8G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8pXOIZM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/qNQf8G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8pXOIZM8"
Date: Tue, 7 Jan 2025 16:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736264648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FRRC2Sx1ANlYfEV2Wva1xaqYX27Qfnh9caqO/slSS4=;
	b=b/qNQf8GcYl+46U4LTJorAjjfpbr+6GIagX7nBtMsZyd/gx/BHWUeZnyIMLHRKNaVLjw+U
	ze6X3HQPxZARmuhswrGB87y8YKI4tg4HEz0QJstdFYQrpEJ3YUhpvCoke7jpsfQznSUngT
	AHL5cp0KFQSJRYs6S663F+axfSoDVqx/GurMz97VnLEJdAfklwEDJ/k+yzD4t/PtJiDi1M
	WjA1rj+CtRtJaeKYIHu1MqPozCVertX97y+XbpbJnX1ORy8T0DFwiJ/E8WE0aJFPObFVSm
	mDQf+WNa/v/pLBmYQpzPrkzbwGajmyoeY2X6bwOpwMwl67PIfyPSRlMBItbkKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736264648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9FRRC2Sx1ANlYfEV2Wva1xaqYX27Qfnh9caqO/slSS4=;
	b=8pXOIZM8lK0ml8vG3dEWoYnKZ6d5JffB3ifgCjbM8Pt8UXfIaOjyNX+nFKhiOC8KFhCxFT
	zraYG1CM1wjS1yAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Elliot Berman <elliot.berman@oss.qualcomm.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
Message-ID: <20250107154407.OQ2ml1iY@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de>
 <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
 <CABCJKucZKvFcTQEqbKNUfdYv-upxsH6cmw1=iHUORPFJc+vKHQ@mail.gmail.com>
 <20250103101357180-0800.eberman@hu-eberman-lv.qualcomm.com>
 <CABCJKucPR7ty7oPn1NYkJidv_Mk46+E0B0vmGhBXz4Stt+vujA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKucPR7ty7oPn1NYkJidv_Mk46+E0B0vmGhBXz4Stt+vujA@mail.gmail.com>

On 2025-01-06 13:24:28 [-0800], Sami Tolvanen wrote:
> Hi,
Hi,

> OK, great. That makes sense. Thanks for taking the time to test this!

Thank you two for testing, confirming and adding more informations to
what and why. I take some of this for the patch description.

> Sami

Sebastian
