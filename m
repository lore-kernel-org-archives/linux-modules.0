Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754D481B1;
	Mon,  6 May 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976880; cv=none; b=UtQg1eXfbfovM2nqDErmodSQMOnh5MtmZVPewsWrtOKXXg/HqULuzc90I5CiSyT5iG0nNFwPVmI38TGF9O+Ww3zLep8Oh5Oiaj6+llPZeeYfDGv9P3gfJHqjcdNph7CvzRPF2aelRwIfp24N+Aq3+sJ0fEqJ/K2mQqirX6u9krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976880; c=relaxed/simple;
	bh=J6lwFhRAUTQqgryMYvr9KovWpiaYAxESsqduXrYIcBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aahkMfmG0co22689/7B65H1jB/lxUOZmWsSfOTGd8Igy+CSI8r/9u7n0hM+/UPicZD7WR2lr2+IHVhX5IVVWsnZnofTl+Tutcj7jdzr/mGlFxg08lhQwYBoL3sx9WNpLi/2sbU81sOx80k4B2qF45tExjA7O0tKJG/lR3rN+f00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYbf2BJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYbf2BJg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4464lTsT004249;
	Mon, 6 May 2024 06:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=RIGEcxO
	9iBsq9RdQ7hRo5WlqUTKj0bvYnPS1dfwVru8=; b=OYbf2BJg/nJyimJpCpvDUYw
	CBg8Qwh1iCWwVGdP4A4TN4zAy4X2nLOskANFYXL0GRzKIwKWZOeyS8BdaTaXbwJf
	eR0x2f9Q4o/ew/42btx0/579ZP4k+byhdqsn9APDRHOBgPjEEBWxUAGmCKeOhHI2
	BJKjb51iuaDER3t7UEJpNDudIkclTYE/YbvNmANoR38ZeJcji7HeEJFkVjDEjbz5
	1IiSl1ccMrr+V9OO5oNGc3Tt8LBKtPq7iM4QSXySyyqMjbI3vchQ+ECwSzHo/OVl
	qAwpqwbDiSIUPke7Py0g0+DS4QSx+PJDEwbXGSdO1+kT3duDHaUD9xL/kKCXtjw=
	=
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwe6rtqry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 06:27:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4466RtsI004039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 06:27:55 GMT
Received: from la-sh003-lnx.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 23:27:54 -0700
From: Joey Jiao <quic_jiangenj@quicinc.com>
To: <linux-modules@vger.kernel.org>
CC: <quic_jiangenj@quicinc.com>, Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/module: disable cfi for do_mod_ctors
Date: Mon, 6 May 2024 14:27:13 +0800
Message-ID: <20240506062713.3360093-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -B47IhXWWiA2NCBlPHeLJXSS0am_gHDx
X-Proofpoint-GUID: -B47IhXWWiA2NCBlPHeLJXSS0am_gHDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_03,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=892 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405060039

CFI failure when both CONFIG_CONSTRUCTORS and CFI_CLANG enabled.

CFI failure at do_init_module+0x100/0x384 (target:
tsan.module_ctor+0x0/0xa98 [module_name_xx]; expected type: 0xa540670c)

Disable cfi for do_mod_ctors to avoid cfi check on mod->ctors[i]().

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1e8a7a9d6c1..d51e63795637 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2453,6 +2453,7 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 }
 
 /* Call module constructors. */
+__nocfi
 static void do_mod_ctors(struct module *mod)
 {
 #ifdef CONFIG_CONSTRUCTORS
-- 
2.43.2

