function enf = BernoulliBeam2D_EquivalentNodeForce( ie, p1, p2, idof )
%   �������Էֲ����صĵ�Ч�ڵ���
%   �������:
%      ie  -----  ��Ԫ��
%      p1  -----  ��һ���ڵ��ϵķֲ�������ֵ
%      p2  -----  �ڶ����ڵ��ϵķֲ�������ֵ
%      idof  ---  �ֲ��������࣬�����������漸��
%                  1 ---  �ֲ�������
%                  2 ---  �ֲ�������
%                  3 ---  �ֲ����
%   ����ֵ:
%      enf -----  ��������ϵ�µ�Ч�ڵ�������
    global gElement gNode
    enf = zeros( 6, 1 ) ; % ���� 6x1 �ĵ�Ч�ڵ�������
    xi = gNode( gElement( ie, 1 ), 1 ) ;
    yi = gNode( gElement( ie, 1 ), 2 ) ;
    xj = gNode( gElement( ie, 2 ), 1 ) ;
    yj = gNode( gElement( ie, 2 ), 2 ) ;
    L = sqrt( (xj-xi)^2 + (yj-yi)^2 ) ;
    switch idof 
    case 1     %  �ֲ������� 
        enf( 1 ) = (2*p1+p2)*L/6 ;
        enf( 4 ) = (p1+2*p2)*L/6 ;
    case 2     %  �ֲ�������
        enf( 2 ) = (7*p1+3*p2)*L/20 ;
        enf( 3 ) = (3*p1+2*p2)*L^2/60 ;
        enf( 5 ) = (3*p1+7*p2)*L/20 ;
        enf( 6 ) = -(2*p1+3*p2)*L^2/60 ;
    case 3     %  �ֲ����
        enf( 2 ) = -(p1+p2)/2 ;
        enf( 3 ) = (p1-p2)*L/12 ;
        enf( 5 ) = (p1+p2)/2 ;
        enf( 6 ) = -(p1-p2)*L/12 ;
    otherwise
        disp( sprintf( '�ֲ�����������󣬵�Ԫ��:%d',ie ) ) ;
    end
    
    T = BernoulliBeam2D_TransformMatrix( ie );%  ���㵥Ԫ��ת������
    enf = T * enf;%  �ѵ�Ч�ڵ���ת��������������
return