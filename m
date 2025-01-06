Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00831DF24B
	for <linux-modules@vger.kernel.org>; Mon,  6 Jan 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186455; cv=none; b=sLtF45bd/Q8x3UDfYJKqBwihxIzQV2rWIAewq6ObsZgM2sw+Y8ITgJBTJ9ep6//GHPjiZ10e4StN7dZQl9kb9yKAmkHkWxpSFXGVs5OJ5w9PcbUD+S3QRaLIwHKBVT71+r7pTJhWFlGjVIPhhYzemgBN9MFVEgAdPQAgxZvAqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186455; c=relaxed/simple;
	bh=C/tw2D77F66nxRbbmCdQXH6xlG644LkMa0e1oRlDt0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU07uXfSqRK3jJveE3T3BqJsv7mYZaEypc0fa1JrH29HsFODc617HVCDOHa3kArCzDJODWD+yhTqzRlpQ5g9XYIuX1cX03IMHsVwX3jZu/oQy9M1AtpHKR1RaikOjwUzvlJhrqlRsUq8lMrdhWW3OBenaj4lJ0xcqBWA695AhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQy88ilq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQy88ilq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506FqYlM010669
	for <linux-modules@vger.kernel.org>; Mon, 6 Jan 2025 18:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/cfr5P4dE8MjkGs8GrCOadceWYbHsj0bsOjSYvd4Cog=; b=lQy88ilqDlzqL+GY
	QjMXbWJNWzNE+pzyiXnFKIe/Gby4pM+TT+wDSXe+srfCXcaqFavJDs/Rpz0Y6BAz
	/ZgVkfKeH4s0cO3BGdMC5IZAlR2gclRS8b8+/q8sc3tl5FyLjvIC/iSP5mogbkLT
	4AcIqRhJmvamSFF/XdqinujJ2WPYZrG8JFE57MpDqVq1o+2H5R7aiGyb/bFvTFBC
	U38gBezXgUzuZ/b83/BKPbUYpqybUXoMK/BAH3JsSYi4iKQaxBsyec27HYavXQDw
	g1ALEWybu+8yuVQJbMZ7Bah4RBPZaNjWWGiyVZ2icrTHlHBM7jv+GgzhWQIrQp4q
	Oja+5w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440j7009bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 18:00:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21648ddd461so263362835ad.0
        for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 10:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186451; x=1736791251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cfr5P4dE8MjkGs8GrCOadceWYbHsj0bsOjSYvd4Cog=;
        b=uCdKS8PbnaDGyMES/l7ipHMghGjmEBLnW43HCcvsvdEZdv1DOF60XhaWwIn29F0njJ
         JhdY3z9pcjgctOxp7sfVuVJba2CJrv+WhJFcNd5hJEWjC1JRC0o/92v9e03szRQXcd4J
         B3Ygkxp3bq2iordaLIfpMFYEz/6LBVa0Rhdr+iG5uyAcDxQMsFfW0HW38UXZGI0SnpGV
         b+cWvPAw0YDH9PnDKtHz4LdyCTwhEkr1vsA2DG/TV2IrSSkKMABVZxPsbRMMI/aQEK2V
         ZkXVxNjoINE4YAewo70HHN5vASa6+ECHhfCsfYWzP5UAMc6EgHaB+Hsk4bJt4MpWVkou
         HkAg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DZSr6zjV5N0mclDxdc5/RbENA7y+spMu8hu5zw3IF9Dyk0wC0Fw2VJdxWtA1alGBeOpVqm2hKwx0J7yG@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvC4INFBg3mPCW+ofWe8cLC9gJplSbBbdHXXhFNxBEM3Cp2iU
	ph7Qrfm9MeCSO83XiInMQzpzuD2GTv2pkTlMTmlaKQG74GxRv0DEKXQM3UGs+BwXED7Uhhen9vn
	irjPoQr6sA/TEdCNINQxMMYaOE0OYE1DPCJRCQeR14P9e8kHTZlSMw2MWPFYOwW5a
X-Gm-Gg: ASbGncv3dJdnnvMzr//Ij7SwjZsVGDu9gncrD04Vy3PszfkIs99l91p5QCocks7wwun
	mXVMXGjNf6B3pXu/YRhqyqdpOeLTqZkD5WvNy9XxlozAPYM7Y4L1f5qY/eIKisfbKW4LD3UF4N0
	TiD3TUN2FjE41BQY2uwQfVI/Xz0h8+LBt8d2mmWVEGcHa+VhuMVhBtwWFhFbRtUHJY+S6zjNK1n
	s6FQFRtyI5Y47C7k1qfaO5W5RfrWht/MqSv/PkUVdlSwr/rOY3OIsSVMfg3jthsEqkSy/caph/a
	s0OM5MNvUQr+3O+hphrDlDrmCP37SrRrJfgF
X-Received: by 2002:a17:903:320a:b0:216:4cc0:aa4e with SMTP id d9443c01a7336-219e6f37f88mr877718595ad.47.1736186450479;
        Mon, 06 Jan 2025 10:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKxeP0fYXWNRSuBo63GlatOZdUBa1wq+1u6CfOeT7r7LLcU9ZygtK9cUJtqM9KXRbYsaYzoA==
X-Received: by 2002:a17:903:320a:b0:216:4cc0:aa4e with SMTP id d9443c01a7336-219e6f37f88mr877718005ad.47.1736186449960;
        Mon, 06 Jan 2025 10:00:49 -0800 (PST)
Received: from hu-eberman-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7457sm289404095ad.201.2025.01.06.10.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 10:00:49 -0800 (PST)
Date: Mon, 6 Jan 2025 10:00:47 -0800
From: Elliot Berman <elliot.berman@oss.qualcomm.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Gomez <da.gomez@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
Message-ID: <20250103101357180-0800.eberman@hu-eberman-lv.qualcomm.com>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de>
 <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
 <CABCJKucZKvFcTQEqbKNUfdYv-upxsH6cmw1=iHUORPFJc+vKHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKucZKvFcTQEqbKNUfdYv-upxsH6cmw1=iHUORPFJc+vKHQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: nJX_FbLYf05Tmh7LYo_20LD3PcYmVhiz
X-Proofpoint-GUID: nJX_FbLYf05Tmh7LYo_20LD3PcYmVhiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060158

On Thu, Jan 02, 2025 at 04:24:22PM -0800, Sami Tolvanen wrote:
> Hi Elliot,
> 
> On Mon, Dec 30, 2024 at 7:33 PM Elliot Berman
> <elliot.berman@oss.qualcomm.com> wrote:
> >
> > On Fri, Dec 20, 2024 at 06:41:42PM +0100, Sebastian Andrzej Siewior wrote:
> > > __module_address() can be invoked within a RCU section, there is no
> > > requirement to have preemption disabled.
> > >
> > > I'm not sure if using rcu_read_lock() will introduce the regression that
> > > has been fixed in commit 14c4c8e41511a ("cfi: Use
> > > rcu_read_{un}lock_sched_notrace").
> > >
> >
> > You can replace the rcu_read_lock_sched_notrace() with guard(rcu)().
> > Regular rcu lock doesn't generate function traces, so the recursive loop
> > isn't possible.
> >
> > I've tested:
> >  - the current kernel (no recursive loop)
> >  - Revert back to rcu_read_lock_sched() (fails)
> 
> Which kernel version did you test? I assume something pre-KCFI as
> arm64 doesn't use this code since v6.1.
> 

Ah, thanks for calling me out. I dug a bit more, I thought I was looking
at a recursive loop in the ftrace buffers, but was actually the expected
behavior. When I tested on the other configurations, the stm dummy
driver hadn't kicked in yet by the time I looked at the ftrace. Indeed,
this function code is not used on arm64.

I experimented with an x86 build as well and I was able to get the hang
I remember seeing after some tweaks to force a CFI failure. Still,
guard(rcu)() is okay by me :)

> >  - Your series as-is (no recurisve loop)
> 
> Note that this patch only adds a comment to is_module_cfi_trap(), so I
> wouldn't expect a functional change.
> 

Agreed I wouldn't expect it to make any issues; I mentioned it for
completeness sake.

Regards,
Elliot
