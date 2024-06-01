Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB55136A;
	Sat,  1 Jun 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717201396; cv=none; b=N+XHp6ctCJBfiQX5z+ieslMWM6Li6Y1ZaHDMq/BAmI42Uq45yTQxfVuXOB3bhdkFkZETKjqBES/4iQDDrm2LjG4/qRr9pRgi7QLvsMy3LpZmBwl0sTzaXcu5Sqx7+tYp0xSr+0B0hqTJJ44Gb7BBMX4ZVwvaBs0IZCRcg9HLB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717201396; c=relaxed/simple;
	bh=1njJ3xLVMmnFjC8+Ano2goV3domkrvrOvZgZSuISQ1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sxQbrHR3w5OcvCkk/zza4gIWuGWX/3IfPeyBwpURfpT9B5qFHCVLzMoFdeZT8OVpa1wXQzZ/iM1anq4kHYMfYgTh1idyh8Yl3IDMgsoIdQx0WYSvqmPgxqvk+cXDhrh/JQ1AcBRoQPEqC4T4iEruwwXcM8E0kVzoHJKP4255Ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JzNP8cNm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JzNP8cNm"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGtWBV003196;
	Sat, 1 Jun 2024 00:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f7TPuE6UqHPQWhDgSspn37
	QmivY2yzCp9zT70alc2CY=; b=JzNP8cNmUoJUrFkONp7AeWdpSBAJxhkRVCpkmE
	p0MRT2Ms5WUttfyuPYrMc0QGgCr1QM+TT6sGyA39RdCkTvxTLfiX6BNd61zqODDs
	NrLQvCrc2/yGk5DCAkUuw2wtqcjkjoIQSPI6TD9/L3d412FC9SLEost/Jj2LZ7Px
	OenRuJNF0c2keV/2blxeX83SYleDri3xbR8+UBCBed9GgwNWEUlDrsVCN5z3w3ly
	MPd7dAv1srXTYijYvZJ0kuhBtYyrH0oi23ulDlZpyxz+bfOlCSCxIfBgSnG6YJ4q
	4ycOqCHAeEi75g082jk/lRwA6a3RlrAoJSa1g3zQuOOoAtVw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfa9bjfjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 00:23:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4510NAew020090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 00:23:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 17:23:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 17:23:09 -0700
Subject: [PATCH] lib/test_kmod: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_kmod-v1-1-fdf11bc6095e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOxpWmYC/x3MQQqDMBBG4avIrDugsWLpVUqRxPzWoSaWTFoE8
 e5Nu/wW7+2kSAKla7VTwkdU1ljQnCoaZxsfYPHFZGpzrru24eB5EccZmodnWD1fWjcZoEdvOir
 ZK2GS7b+83YudVbBLNo7zb7RIfG8crGYkOo4v8qFThYEAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qWd3-jOZ8HfKaEvWut0oYzeTnNi7Wj7S
X-Proofpoint-GUID: qWd3-jOZ8HfKaEvWut0oYzeTnNi7Wj7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010000

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kmod.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_kmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 1eec3b7ac67c..064ed0fce75a 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1223,4 +1223,5 @@ static void __exit test_kmod_exit(void)
 module_exit(test_kmod_exit);
 
 MODULE_AUTHOR("Luis R. Rodriguez <mcgrof@kernel.org>");
+MODULE_DESCRIPTION("kmod stress test driver");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_kmod-83bf2ee7e725

